// import 'dart:async';

import 'dart:typed_data';

import 'package:Ran/generated/android_manager.pbgrpc.dart';
import 'package:Ran/generated/app_manager.pb.dart';
import 'package:Ran/rpc/grpc_client.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../storage/state.dart';
import 'hook/module_list_view.dart';

class AppInstalledItemView extends StatefulWidget {
  final PackageInfo info;
  final bool showEnabledAppOnly;
  final Function callback;

  const AppInstalledItemView(
      {Key? key,
      required this.info,
      required this.showEnabledAppOnly,
      required this.callback})
      : super(key: key);

  @override
  _AppInstalledItemView createState() => _AppInstalledItemView();
}

class _AppInstalledItemView extends State<AppInstalledItemView> {
  bool _selected = false;
  bool _notSet = true;
  bool _visible = true;
  static Logger log = Logger("AppInstalledItemView");

  // a matrix definition of a greyscale filter
  // see https://api.flutter.dev/flutter/dart-ui/ColorFilter/ColorFilter.matrix.html
  // see https://www.w3.org/TR/filter-effects-1/#grayscaleEquivalent
  static const ColorFilter greyscale = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  @override
  void initState() {
    // print(
    //     "app_installed_item initState: showEnabledAppOnly:${widget.showEnabledAppOnly}");
    super.initState();
    if (widget.showEnabledAppOnly) {
      _visible = false; //默认隐藏
    }
  }

  _buildIcon() {
    var info = widget.info;
    var filter;
    //主动拒绝
    // if (!_notSet && !_selected) {
    // if (!_selected) {
    //   filter = greyscale;
    // } else {
    //   filter = ColorFilter.mode(Colors.transparent, BlendMode.saturation);
    // }

    // print("info.running: ${info.running}");

    // if (info.running) {
    filter = ColorFilter.mode(Colors.transparent, BlendMode.saturation);
    // } else {
    //   filter = greyscale;
    // }
    // filter = ColorFilter.mode(Colors.transparent, BlendMode.saturation);

    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          ColorFiltered(
            colorFilter: filter,
            child: Image.memory(Uint8List.fromList(info.icon),
                gaplessPlayback: true),
          ),
          // Positioned(
          //   child: Icon(Icons.help, size: 20, color: Colors.yellow.shade700),
          // ),
        ],
      ),
    );

    // var img =
    //     Image.memory(Uint8List.fromList(info.icon), gaplessPlayback: true);
  }

  @override
  Widget build(BuildContext context) {
    var info = widget.info;

    return Visibility(
      visible: _visible,
      child: _buildView(info),
    ); // Widget to display the list of project
  }

  _openSetting(String pkgName) {
    // var req = AppControlReq.create();
    // req.pkgName = pkgName;
    // req.cmd = "setting";
    // GrpcClient.grpcClient.appControl(req).then((resp) {
    //   // print("app control resp: $resp");
    //   widget.callback();
    //   // setState(() {});
    // });
  }

  _buildView(PackageInfo info) {
    return ListTile(
      title: Text(info.name),
      subtitle: Text(info.pkgName),
      onTap: () {
        _openSetting(info.pkgName);
        // Navigator.push(
        //   context,
        //   //fixme wuhx
        //   // MaterialPageRoute(builder: (context) => AppDetailView(info: info)),
        //   MaterialPageRoute(
        //       builder: (context) => MetricView(pkgName: info.pkgName)),
        // );
      },
      leading: _buildIcon(),
      // trailing: _selectPopup(info.pkgName),

      trailing: IconButton(
        icon: Icon(Icons.bug_report),
        tooltip: "调试${info.pkgName}",
        onPressed: () {
          UiState.reStartAppWithDebug(info.pkgName).then((value) {
            print("reStartAppWithDebug: $value");

            //等新的服务起来，否则会连上老服务
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModuleListView(
                        key: ValueKey(info.pkgName), pkgName: info.pkgName)),
              );
            });
          });
        },
      ),
    );
  }
}
