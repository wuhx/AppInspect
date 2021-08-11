import 'package:Ran/generated/android_manager.pbgrpc.dart';
import 'package:Ran/ui/hook/symbol_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../storage/state.dart';

class SymbolListView extends StatefulWidget {
  final String moduleName;

  const SymbolListView({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  _SymbolListView createState() => _SymbolListView();
}

class _SymbolListView extends State<SymbolListView> {
  final log = Logger('SymbolListView');

  static String filter_text = "";
  static bool showFilterBox = false;
  // static bool _force_refresh = false;
  static int totalApps = 0;
  late FocusNode filterFocusNode;
  var isVpnStarted = false;
  static bool gHideSystemApp = false;
  static bool gShowEnabledAppOnly = false;

  static bool mIsFetchInProgress = true;
  static String mErr = "";

  List<HookSymbolInfo> mSymbolInfoList = [];
  List<HookInfo> mHookInfoList = [];

  HookInfo? _getHook(HookSymbolInfo info) {
    var filter = mHookInfoList.where((element) {
      var res = (element.symbolName == info.symbolName &&
          element.moduleName == info.moduleName);
      return res;
    });
    if (filter.isNotEmpty) {
      return filter.first;
    } else {
      return null;
    }
  }

  _callRpc() async {
    var value = await UiState.hookListSymbols(widget.moduleName);
    log.info("_provisionList return: ${value.length} items");
    mSymbolInfoList = value;

    var infos = await UiState.hookInfoList();
    log.info("hookInfoList return ${infos.length} items");
    mHookInfoList = infos;
  }

  _provisionList() async {
    mIsFetchInProgress = true;
    await _callRpc();
    log.info("_callRpc finish");
    mIsFetchInProgress = false;
    setState(() {});

    // UiState.hookListSymbols(widget.moduleName).then((value) {
    //   mIsFetchInProgress = false;
    //   log.info("_provisionList return: ${value.length} items");
    //   mSymbolInfoList = value;
    //   setState(() {});
    // }, onError: (e) {
    //   mIsFetchInProgress = false;
    //   mErr = e.toString();
    //   log.severe("_hookListModules error: $mErr. ");
    //   setState(() {});
    // });
  }

  @override
  void initState() {
    super.initState();
    log.info("init state");
    _provisionList();

    filterFocusNode = FocusNode();
    // filterFocusNode.addListener(() {
    //   print("symbol_list_view FocusNode OnChange");
    //   if (!filterFocusNode.hasFocus) {
    //     FocusScope.of(context).requestFocus(filterFocusNode);
    //   }
    // });
  }

  @override
  void dispose() {
    print("symbol_list_view  dispose");
    filterFocusNode.dispose();
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
      var list = _filterList(mSymbolInfoList);
      return _buildListView(list);
    }
  }

  Widget _buildListView(List<HookSymbolInfo> items) {
    return ListView.builder(
      // controller: scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        HookSymbolInfo info = items[index];
        var hook = _getHook(info);
        var item = new SymbolDetailView(
          info: info,
          hook: hook,
          showEnabledAppOnly: false,
        );
        return Column(
          children: <Widget>[item],
        );
      },
    );
  }

  Future<void> _forceRefresh() async {
    _provisionList();
  }

  //根据条件过滤
  List<HookSymbolInfo> _filterList(List<HookSymbolInfo> list) {
    //先按名称排序
    // mModuleList.sort((a, b) => b.pkgName.compareTo(a.pkgName));

    if (filter_text.trim() != "") {
      return list.where((element) {
        var res1 = element.symbolName
            .toLowerCase()
            .contains(filter_text.trim().toLowerCase());
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
      title: Text(widget.moduleName),
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
                  hintText: 'search modules with name'),
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
