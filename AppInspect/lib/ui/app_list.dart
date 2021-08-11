import 'package:Ran/generated/app_manager.pb.dart';
import 'package:Ran/ui/app_installed_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';
import '../storage/state.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter/foundation.dart' show kIsWeb;

class AppListView extends StatefulWidget {
  const AppListView({Key? key}) : super(key: key);

  @override
  _AppListView createState() => _AppListView();
}

class _AppListView extends State<AppListView> {
  final log = Logger('AppListView');

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
  List<PackageInfo> mPackageInfoList = [];

  void setAppListState() {
    log.fine("setAppListState");

    _fetchPackageList();
  }

  @override
  void initState() {
    super.initState();
    log.info("init state");
    _fetchPackageList();

    if (!kIsWeb) {
      _getIps().then((ips) => _showInfoDialog(ips));
    }

    filterFocusNode = FocusNode();
    filterFocusNode.addListener(() {
      if (!filterFocusNode.hasFocus) {
        // print("filterFocusNode requestFocus");
        FocusScope.of(context).requestFocus(filterFocusNode);
      }
    });
    // scrollController = ScrollController();
  }

  @override
  void dispose() {
    filterFocusNode.dispose();
    // scrollController.dispose();
    super.dispose();
  }

  Widget _buildListView() {
    if (mIsFetchInProgress) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (mErr.isNotEmpty) {
      return _buildErrorView(mErr);
    } else {
      var piList = _filterPackageList(mPackageInfoList);
      totalApps = piList.length;
      log.info(
          "_filterPackageList: gHideSystemApp:$gHideSystemApp, filter_text:$filter_text totalApps: $totalApps");
      return _buildListViewFromPackageInfoList(piList);
    }
  }

  Widget _buildListViewFromPackageInfoList(List<PackageInfo> packageInfoList) {
    return ListView.builder(
      // controller: scrollController,
      itemCount: packageInfoList.length,
      itemBuilder: (context, index) {
        PackageInfo info = packageInfoList[index];
        var item = new AppInstalledItemView(
          info: info,
          showEnabledAppOnly: false,
          callback: setAppListState,
        );
        return Column(
          children: <Widget>[item],
        );
      },
    );
  }

  _buildErrorViewInternal(String msg) {
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

  _buildErrorView(String msg) {
    var match = "adb connect to 127.0.0.1:5555 fail";
    var errMsg =
        "adb connect to 127.0.0.1:5555 fail!\nPlease run \"adb tcpip 5555\" on your computer \nwith device USB connected";

    if (msg.contains(match))
      return _buildErrorViewInternal(errMsg);
    else {
      return _buildErrorViewInternal(msg);
    }
  }

  Future<void> _forceRefresh() async {
    _fetchPackageList();
  }

  _fetchPackageList() {
    mIsFetchInProgress = true;
    UiState.fetchPackageList(true).then((value) {
      mIsFetchInProgress = false;
      log.info("_fetchPackageList return: ${value.length} items");
      mPackageInfoList = value;
      setState(() {});
    }, onError: (e) {
      mIsFetchInProgress = false;
      mErr = e.toString();
      log.severe("_fetchPackageList error: $mErr. ");
      setState(() {});
    });
  }

  //根据条件过滤app
  List<PackageInfo> _filterPackageList(List<PackageInfo> piList) {
    //先按名称排序
    mPackageInfoList.sort((a, b) => b.pkgName.compareTo(a.pkgName));

    //再按安装时间排序，否则由于大量系统应用安装时间一样，排序会随机
    mPackageInfoList
        .sort((a, b) => b.firstInstallTime.compareTo(a.firstInstallTime));

    List<PackageInfo> pkgsWithoutSelf = mPackageInfoList.where((element) {
      var res = !element.pkgName.contains("com.cloudmonad.inspect");
      // print("element: ${element.pkgName}, res: $res");
      return res;
    }).toList();
    // print("pkgsWithoutSelf: ${pkgsWithoutSelf.length}");
    List<PackageInfo> nonSystemApps;
    if (gHideSystemApp) {
      nonSystemApps = pkgsWithoutSelf.where((element) {
        // print("sourceDir: ${element.sourceDir}");
        return element.sourceDir.startsWith('/data/app');
      }).toList();
    } else {
      nonSystemApps = pkgsWithoutSelf;
    }
    // print("nonSystemApps: ${nonSystemApps.length}");
    // var enableApps;
    // if (gShowEnabledAppOnly) {
    //   enableApps = value.where((element) => {element.pkgName});
    // }
    // print("filter pkgs with $filter_text, found ${value.length} pkgs");
    if (filter_text.trim() != "") {
      return nonSystemApps.where((element) {
        var res1 = element.name
            .toLowerCase()
            .contains(filter_text.trim().toLowerCase());
        var res2 = element.pkgName
            .toLowerCase()
            .contains(filter_text.trim().toLowerCase());
        return res1 | res2;
      }).toList();
    } else {
      return nonSystemApps.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        child: _buildListView(),
        onRefresh: _forceRefresh,
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      leading: new IconButton(
          icon: new Icon(Icons.help),
          onPressed: () {
            //wuhx test
            // UiState.runRootCmd("touch /data/local/tmp/HELLEO").then((value) {
            // var cmd = "am force-stop com.cloudmonad.inspect";
            // UiState.runRootCmd(cmd).then((value) {
            //   log.info("resp: $value");
            // });

            _getIps().then((ips) => _showInfoDialog(ips));
            // UiState.updateSharedPreferences(_pkgs.toList());
            // Navigator.pop(context);
          }),
      centerTitle: true,
      title: Text('Chose an App to inspect'),
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
                  hintText: 'search in $totalApps apps'),
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

  Future<List<String>> _getIps() async {
    var resp = await UiState.runRootCmd("ip r");
    /*
    10.140.134.176/29 dev rmnet_data2 proto kernel scope link src 10.140.134.180
192.168.0.0/24 dev wlan0 proto kernel scope link src 192.168.0.106
     */
    print("resp: $resp");
    var result = resp.trim().split("\n").map((line) {
      var ip = line.trim().split(" ").last;
      // print("ip: $ip");
      return ip;
    }).toList();
    return result;
    // if (result.isEmpty) {
    //   return List.empty();
    // } else {
    //   return result;
    // }
  }

  _dialogBody(List<String> ips) {
    var sb = StringBuffer();
    ips.forEach((ip) {
      sb.writeln("<li>http://$ip:10020</li>");
    });
    var ipStr = sb.toString();
    // print("ipStr: $ipStr");

    return Center(
      child: Html(
          data: """<div>

        <ul>
        <li>本应用支持在电脑上远程操作（推荐）</li>
        <li> 打开浏览器访问以下地址之一 </li>
        $ipStr
  
        </ul>
        <!--You can pretty much put any html in here!-->
      </div>""",
          onLinkTap: (String? url, RenderContext context,
              Map<String, String> attributes, dom.Element? element) {
            // print("open url: $url");
            launch(url!);

            //open URL in webview, or launch URL in browser, or any other logic here
          }
          // )
          ),
    );
  }

  Future<void> _showInfoDialog(List<String> ips) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Help'),
          content:
              Container(height: 150.0, width: 300.0, child: _dialogBody(ips)),
          actions: <Widget>[
            TextButton(
              child: Text('got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {}
