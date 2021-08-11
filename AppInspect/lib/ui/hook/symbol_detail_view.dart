// import 'dart:async';

import 'dart:typed_data';

import 'package:Ran/generated/android_manager.pbgrpc.dart';
import 'package:Ran/rpc/grpc_client.dart';
import 'package:Ran/ui/hook/symbol_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:logging/logging.dart';
import '../../storage/state.dart';

class SymbolDetailView extends StatefulWidget {
  final HookSymbolInfo info;
  final HookInfo? hook;
  final bool showEnabledAppOnly;

  const SymbolDetailView(
      {Key? key,
      required this.info,
      required this.showEnabledAppOnly,
      this.hook})
      : super(key: key);

  @override
  _SymbolDetailView createState() => _SymbolDetailView();
}

class _SymbolDetailView extends State<SymbolDetailView> {
  bool _visible = true;
  bool hooked = false;
  static Logger log = Logger("SymbolDetailView");

  @override
  void initState() {
    super.initState();
    if (widget.showEnabledAppOnly) {
      _visible = false; //默认隐藏
    }
  }

  @override
  Widget build(BuildContext context) {
    var info = widget.info;

    return Visibility(
      visible: _visible,
      child: _buildView(info),
    ); // Widget to display the list of project
  }

  _buildView(HookSymbolInfo info) {
    var style;
    if (widget.hook == null) {
      style = TextStyle(color: Colors.black);
    } else {
      style = TextStyle(color: Colors.red);
    }

    return ListTile(
      title: Text(
        info.symbolName,
        style: style,
      ),
      subtitle: Text("0x${info.address.toHexString()}+${info.size}"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SymbolHome(
                    moduleName: info.moduleName,
                    symbolName: info.symbolName,
                    hook: widget.hook,
                  )),
        );
      },
      // leading: _buildIcon(),
      // trailing: _selectPopup(info.pkgName),
      // trailing: Switch(
      //   value: _selected,
      //   onChanged: (bool value) {
      //     setRule(value);
      //   },
      // ),
    );
  }
}
