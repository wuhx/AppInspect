import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class FloatDialog extends StatefulWidget {
  // final String title, descriptions, text;
  // final Image img;

  const FloatDialog({Key? key}) : super(key: key);

  @override
  _FloatDialogState createState() => _FloatDialogState();
}

class _FloatDialogState extends State<FloatDialog> with WidgetsBindingObserver {
  Timer? _timer;

  @override
  void initState() {
    // print("_FwDialogState initState");
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    // GrpcClient.fwDialogUi().then((resp) {
    //   print("fwDialogUi load: ${resp.pkgName}");
    //   // _app = resp.pkgName;
    //   ui = resp;
    // });
  }

  @override
  void dispose() {
    // print("_FwDialogState dispose");
    WidgetsBinding.instance!.removeObserver(this);
    if (_timer != null) {
      // print("cancel timer");
      _timer!.cancel();
    }

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print("_FwDialogState didChangeAppLifecycleState: $state");
    if (state == AppLifecycleState.detached) {
      // print("_FwDialogState AppLifecycleState.detached pop navigator!");
      // SystemNavigator.pop();
    }
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  Offset? _tapPosition;

  @override
  Widget build(BuildContext context) {
    void _handleTapDown(TapDownDetails details) {
      // print("xxxxx tap on ${details.globalPosition}");
      // var boxSize = MediaQuery.of(context).size; //对话框尺寸
      // var size = window.physicalSize; //屏幕物理尺寸
      // print("xxxx windows size $size");

      // final RenderBox renderBoxDialog =
      //     _keyDialog.currentContext!.findRenderObject() as RenderBox;
      //
      // print("xxxxx _keyDialog size: ${renderBoxDialog.size}");//和MediaQuery.of(context).siz一样
    }

    return new GestureDetector(
      behavior: HitTestBehavior.translucent, //背景点击捕获
      child: build_dialog(context),
      onTapDown: _handleTapDown,
    );
  }

  GlobalKey _keyDialog = GlobalKey();

  Widget build_dialog(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return new WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          key: _keyDialog,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          // child: futureContentBox(context),
          child: contentBox(context),
        ));
  }

  // futureContentBox(context) {
  //   return FutureBuilder<FwDialogUiResp>(
  //       future: GrpcClient.fwDialogUi(),
  //       builder:
  //           (BuildContext context, AsyncSnapshot<FwDialogUiResp> snapshot) {
  //         if (snapshot.hasData) {
  //           FwDialogUiResp resp = snapshot.data!;
  //           //todo get timer from resp
  //           _timer = new Timer(const Duration(milliseconds: 10000), () {
  //             // print("timer timeup");
  //             // SystemNavigator.pop();
  //             // setState(() {});
  //           }); //finish
  //           return contentBox(context, resp);
  //         } else if (snapshot.hasError) {
  //           print("futureContentBox error: ${snapshot.error}");
  //           //error
  //           return Icon(
  //             Icons.error_outline,
  //             color: Colors.red,
  //             size: 60,
  //           );
  //         } else {
  //           //loading
  //           return SizedBox(
  //             child: CircularProgressIndicator(),
  //             // width: 60,
  //             // height: 60,
  //           );
  //         }
  //       });
  // }

  allowButtonRow(BuildContext context, String app) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 20.0)),
        Container(
            child: TextButton(
                onPressed: () {
                  // Navigator.of(context).pop();
                  // print("onPressed accept!");
                  SystemNavigator.pop();
                },
                child: Text(
                  "allow",
                  style: TextStyle(fontSize: 18),
                ))),
        Padding(padding: EdgeInsets.all(8)),
        Container(
            child: TextButton(
                onPressed: () {
                  // Navigator.of(context).pop();
                  // print("onPressed deny!");
                  SystemNavigator.pop();
                },
                child: Text(
                  "deny",
                  style: TextStyle(fontSize: 18),
                ))),
      ],
    );
  }

  // Stack contentBox(BuildContext context, FwDialogUiResp resp) {
  Stack contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Text(
              //   resp.name,
              //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              // ),
              // SizedBox(
              //   height: 15,
              // ),

              Text.rich(
                TextSpan(
                  // text: 'Hello', // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: "hello",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    TextSpan(
                        text: ' is trying to send data to Internet',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal))
                  ],
                ),
              ),

              // Text(
              //   // "${resp.name}(${resp.pkgName}) 尝试访问互联网，是否允许？",
              //   "${resp.name}(${resp.pkgName}) is trying to send data to Internet",
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              //   textAlign: TextAlign.start,
              // ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.center,
                child: allowButtonRow(context, "app.pkg.name"),
              )
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: TextButton(
              //       onPressed: () {
              //         // Navigator.of(context).pop();
              //         print("onPressed accept!");
              //
              //         SystemNavigator.pop();
              //       },
              //       child: Text(
              //         "allow",
              //         style: TextStyle(fontSize: 18),
              //       )),
              // ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // child: Image.memory(Uint8List.fromList(resp.icon))),
                child: Icon(Icons.ac_unit)),
            // child: Image.asset("assets/model.jpeg")),
          ),
        ),
      ],
    );
  }
}
