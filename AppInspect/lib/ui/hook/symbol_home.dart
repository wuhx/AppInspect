import 'package:Ran/generated/android_manager.pbgrpc.dart';
import 'package:Ran/generated/android_manager.pb.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../storage/state.dart';

class SymbolHome extends StatefulWidget {
  final String moduleName;
  final String symbolName;
  final HookInfo? hook;

  const SymbolHome(
      {Key? key, required this.moduleName, required this.symbolName, this.hook})
      : super(key: key);

  @override
  _SymbolHome createState() => _SymbolHome();
}

class _SymbolHome extends State<SymbolHome> {
  final log = Logger('SymbolHome');

  late FocusNode filterFocusNode;
  var isVpnStarted = false;

  late HookInfo mHookInfo;
  // late List<HookArg> mArgs;

  @override
  void initState() {
    super.initState();
    log.info("init state");
    if (widget.hook != null) {
      mHookInfo = widget.hook!;
    } else {
      mHookInfo = HookInfo();
      mHookInfo.moduleName = widget.moduleName;
      mHookInfo.symbolName = widget.symbolName;
      mHookInfo.args.addAll([]);
    }

    filterFocusNode = FocusNode();
    filterFocusNode.addListener(() {
      if (!filterFocusNode.hasFocus) {
        // print("filterFocusNode requestFocus");
        FocusScope.of(context).requestFocus(filterFocusNode);
      }
    });
  }

  @override
  void dispose() {
    filterFocusNode.dispose();
    // scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: _buildViewFromArgs(mHookInfo.args),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var arg = HookArg();
          var index = mHookInfo.args.length;
          arg.hooked = false;
          arg.argName = "arg$index";
          arg.argIndex = index;
          arg.argType = "value";

          mHookInfo.args.add(arg);
          setState(() {});
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  Widget _buildRowHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3, // takes 30% of available width
          child: Text(''),
        ),
        Expanded(
          flex: 6, // takes 30% of available width
          child: Text("参数"),
        ),
        Expanded(
          flex: 2, // takes 30% of available width
          child: Center(child: Text("参数类型")),
        ),
        Expanded(
          flex: 2, // takes 30% of available width
          child: Center(child: Text("hook")),
        )
      ],
    );
  }

  Widget _buildRow(HookArg arg) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3, // takes 30% of available width
          child: Text(arg.argIndex.toString()),
        ),
        Expanded(
          flex: 6, // takes 30% of available width
          child: Text(arg.argName),
        ),
        Expanded(
          flex: 2, // takes 30% of available width
          child: Center(
            child: DropdownButton<String>(
              value: arg.argType,
              onChanged: (String? newValue) {
                setState(() {
                  arg.argType = newValue!;
                });
              },
              items: <String>['value', 'chars', 'jstring']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
            flex: 2, // takes 30% of available width
            child: Center(
              child: Switch(
                value: arg.hooked,
                onChanged: (value) => {
                  setState(() {
                    arg.hooked = !arg.hooked;
                    // log.info("set hooked: ${mHookInfo.args.first.hooked}");
                  })
                },
              ),
            )),
      ],
    );
  }

  Widget _buildViewFromArgs(List<HookArg> args) {
    // var argsView = args.map((arg) => _buildViewFromArg(arg)).toList();

    var argsView = args.map((arg) => _buildRow(arg)).toList();
    var argsViewWithHeader = [_buildRowHeader()];
    argsViewWithHeader.addAll(argsView);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: 600,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: argsViewWithHeader),
        ),
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
      title: Text(widget.symbolName),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              log.info("save $mHookInfo");
              UiState.hookInfoAdd(mHookInfo);
            },
            icon: Icon(Icons.save))
      ],
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {}
