import 'package:Ran/download/download_stub.dart';
import 'package:Ran/generated/android_manager.pbgrpc.dart';
import 'package:Ran/storage/state.dart';
import 'package:Ran/ui/hook/symbol_list_view.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:fixnum/fixnum.dart';

class ModuleDetailView extends StatefulWidget {
  final ModuleInfo info;
  final bool showEnabledAppOnly;

  const ModuleDetailView({
    Key? key,
    required this.info,
    required this.showEnabledAppOnly,
  }) : super(key: key);

  @override
  _ModuleDetailView createState() => _ModuleDetailView();
}

class _ModuleDetailView extends State<ModuleDetailView> {
  bool _selected = false;
  bool _notSet = true;
  bool _visible = true;
  static Logger log = Logger("ModuleInfoView");
  late Int64 mStart;
  late Int64 mEnd;

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

  _buildView(ModuleInfo info) {
    return ListTile(
      title: Text(
        info.name,
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text(info.path),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SymbolListView(moduleName: info.name)),
        );
      },
      // leading: _buildIcon(),
      // trailing: _selectPopup(info.pkgName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // IconButton(
          //   icon: Icon(Icons.download),
          //   tooltip: 'download of ${info.name}',
          //   onPressed: () {
          //     //download file on /system
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.download),
            tooltip: 'dump mem of ${info.name}',
            onPressed: () {
              _showDumpDialog(info.baseAddr, info.baseAddr + info.size);
            },
          ),
        ],
      ),
    );
  }

  _parseAddr(String value) {
    var raw;
    if (value.toLowerCase().startsWith("0x")) {
      raw = value.substring(2);
    } else {
      raw = value;
    }
    var res;
    try {
      res = int.parse(raw, radix: 16);
    } catch (e) {
      res = 0;
    }
    return res;
  }

  _diglogBody() {
    return Center(
      child: Form(
        // key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...[
                      TextFormField(
                        initialValue: mStart.toHexString(),
                        decoration: const InputDecoration(
                          filled: true,
                          // hintText: '0x8008',
                          labelText: 'Start Addr',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (_parseAddr(value) == 0) {
                            return 'Not valid hex string';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          print("onChanged:  $value");
                          if (value.toLowerCase().startsWith("0x")) {
                            mStart = Int64.parseHex(value.substring(2));
                          } else {
                            mStart = Int64.parseHex(value);
                          }
                          print("onChanged: start $mStart");
                        },
                      ),
                      TextFormField(
                        initialValue: mEnd.toHexString(),
                        decoration: const InputDecoration(
                          filled: true,
                          // hintText: '0x8008',
                          labelText: 'End Addr',
                        ),
                        onChanged: (value) {
                          print("onChanged:  $value");
                          if (value.toLowerCase().startsWith("0x")) {
                            mEnd = Int64.parseHex(value.substring(2));
                          } else {
                            mEnd = Int64.parseHex(value);
                          }
                          print("onChanged: end $mEnd");

                          // setState(() {});
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: ElevatedButton(
                              child: const Text('Download'),
                              onPressed: () {
                                _dumpMemRange(mStart, mEnd, widget.info.name)
                                    .then((value) {
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ].expand(
                      (widget) => [
                        widget,
                        const SizedBox(
                          height: 24,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createTag(int index, String tagTitle) {
    return InkWell(
      onTap: () {
        setState(() {});
      },
      child: Chip(
          // backgroundColor:  widget.tagBackgroundColor,

          label: Text(tagTitle),
          deleteIcon: Icon(Icons.done),
          onDeleted: () {}),
    );
  }

  Future<void> _showDumpDialog(Int64 start, Int64 end) async {
    mStart = start;
    mEnd = end;
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dump ${widget.info.name} from memory to file'),
          content: Container(height: 250.0, width: 400.0, child: _diglogBody()),
          // actions: <Widget>[
          //   TextButton(
          //     child: Text('Download'),
          //     onPressed: () {
          //       print("download $mStart - $mEnd");
          //       // Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  _getDumpFileUrl(String path) {
    var filename = path.split("/").last;
    // log.info("filename:$filename, from path: $path");
    var base = Uri.base;
    return "http://${base.host}:${base.port}/dump/$filename";
  }

  Future<String> _dumpMemRange(Int64 start, Int64 end, String name) async {
    var file = await UiState.dumpMemRange(start, end, name);
    var res2 = await UiState.runRootCmd(
        "cp $file /data/data/com.cloudmonad.inspect/site/dump");
    log.info("dump to file $file");
    var url = _getDumpFileUrl(file);
    Download.download(url);
    return file;
  }
}
