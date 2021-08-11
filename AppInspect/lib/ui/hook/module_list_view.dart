import 'dart:io';

import 'package:Ran/generated/android_manager.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../storage/state.dart';

import 'module_detail_view.dart';
import 'package:retry/retry.dart';

class ModuleListView extends StatefulWidget {
  final String pkgName;

  const ModuleListView({
    Key? key,
    required this.pkgName,
  }) : super(key: key);

  @override
  _ModuleListView createState() => _ModuleListView();
}

class _ModuleListView extends State<ModuleListView> {
  final log = Logger('AppModuleListView');

  static String filter_text = "";
  static bool showFilterBox = false;
  static int totalApps = 0;
  late FocusNode filterFocusNode;
  var isVpnStarted = false;
  static bool gHideSystemApp = false;
  static bool gShowEnabledAppOnly = false;

  static bool mIsFetchInProgress = true;
  static String mErr = "";

  List<ModuleInfo> mModuleList = [];

  _getModuleList() {
    mIsFetchInProgress = true;

    final r = RetryOptions(maxAttempts: 8);
    var refut = r.retry(
      () => UiState.hookListModules(widget.pkgName),
      // Retry on SocketException or TimeoutException
      // retryIf: (e) => e is SocketException,
    );

    var fut = refut.then((value) {
      mIsFetchInProgress = false;
      log.info("_hookListModules return: ${value.length} items");
      mModuleList = value;
      setState(() {});
    }, onError: (e) {
      mIsFetchInProgress = false;
      mErr = e.toString();
      log.severe("_hookListModules error: $mErr. ");
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    log.info("init state");
    _getModuleList();

    filterFocusNode = FocusNode();
    // filterFocusNode.addListener(() {
    //   print("module_list_view FocusNode OnChange");
    //   if (!filterFocusNode.hasFocus) {
    //     FocusScope.of(context).requestFocus(filterFocusNode);
    //   }
    // });
  }

  @override
  void dispose() {
    print("module_list_view  dispose");

    filterFocusNode.dispose();
    // scrollController.dispose();
    super.dispose();
  }

  _buildErrorView(String msg) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Text(msg, textAlign: TextAlign.center),
      ],
    ));
  }

  Widget _tryBuildListView() {
    if (mIsFetchInProgress) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (mErr.isNotEmpty) {
      return _buildErrorView(mErr);
    } else {
      var list = _filterList(mModuleList);
      return _buildListView(list);
    }
  }

  Widget _buildListView(List<ModuleInfo> items) {
    return ListView.builder(
      // controller: scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        ModuleInfo info = items[index];
        var item = new ModuleDetailView(
          info: info,
          showEnabledAppOnly: false,
        );
        return Column(
          children: <Widget>[item],
        );
      },
    );
  }

  Future<void> _forceRefresh() async {
    _getModuleList();
  }

  List<ModuleInfo> addrInModule(String str, List<ModuleInfo> list) {
    try {
      var addr = int.parse(str, radix: 16);
      // print("addr parsed: $addr");
      return list.where((element) {
        // print(
        //     " $str :  ${element.baseAddr.toRadixString(16)} size: ${element.size.toRadixString(16)}");

        var res =
            element.baseAddr <= addr && element.baseAddr + element.size > addr;
        return res;
      }).toList();
    } catch (e) {
      return List.empty();
    }
  }

  List<ModuleInfo> _filterList(List<ModuleInfo> list) {
    // mModuleList.sort((a, b) => b.pkgName.compareTo(a.pkgName));

    var input = filter_text.trim();

    var res = addrInModule(input, list);
    if (res.isNotEmpty) {
      return res;
    } else if (input != "") {
      return list.where((element) {
        var res1 = element.path.toLowerCase().contains(input.toLowerCase());

        return res1;
      }).toList();
    } else {
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        child: _tryBuildListView(),
        onRefresh: _forceRefresh,
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
      centerTitle: true,
      title: Text(widget.pkgName),
      actions: <Widget>[
        _searchBox(),
        Padding(padding: EdgeInsets.only(right: 20.0), child: _searchButton())
      ],
    );
  }

  _searchBox() {
    var controller = TextEditingController(
      text: filter_text,
    );
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Visibility(
        visible: showFilterBox,
        child: Expanded(
            flex: 1,
            child: Container(
                // width: 200,
                child: TextField(
              autofocus: false,
              focusNode: filterFocusNode,
              controller: controller,
              onChanged: (value) {
                if (filter_text != value) {
                  filter_text = value;
                  setState(() {});
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      print("onTap select: $value");
                      // _controller.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return ["hide system Apps"]
                          .map<PopupMenuItem<String>>((String name) {
                        var value;
                        if (name.contains("hide")) {
                          value = gHideSystemApp;
                        } else {
                          value = gShowEnabledAppOnly;
                        }

                        return new PopupMenuItem(
                            child: CheckboxListTile(
                          title: Text(name),
                          value: value,
                          controlAffinity: ListTileControlAffinity.leading,

                          onChanged: (bool? value) {
                            print(
                                "onTap PopupMenuItem onChanged $name, value $value");

                            if (name.contains("hide")) {
                              gHideSystemApp = value!;
                              print("onTap gHideSystemApp => $gHideSystemApp");
                            } else {
                              print(
                                  "onTap gShowEnabledAppOnly => $gShowEnabledAppOnly");
                              gShowEnabledAppOnly = value!;
                              print(
                                  "onTap gShowEnabledAppOnly => $gShowEnabledAppOnly");
                            }
                            setState(() {});
                            Navigator.pop(context);
                          },
                          // secondary: const Icon(Icons.hourglass_empty),
                        )
                            // new LabeledCheckbox(
                            //     label: name,
                            //     value: false,
                            //     contentPadding: EdgeInsets.all(0),
                            //     onTap: (bool? value) {
                            //       print("onTap: $name  $value");
                            //
                            //       setState(() {
                            //         // print("onTap: $value");
                            //         // isChecked = value!;
                            //       });
                            //     })
                            );
                      }).toList();
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'search modules with name or address'),
            ))));
  }

  _searchButton() {
    if (!showFilterBox) {
      return IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {
            showFilterBox = true;
            filterFocusNode.requestFocus();

            print("search btn pressed!");
            setState(() {});
            // showSearch(
            //   context: context,
            //   // delegate: CustomSearchDelegate(),
            // );
          });
    } else {
      return IconButton(
          icon: Icon(
            Icons.cancel,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            filter_text = "";
            showFilterBox = false;
            print("search cancel btn pressed!");

            setState(() {});
          });
    }
  }
}
