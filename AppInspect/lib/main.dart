import 'package:Ran/ui/app_list.dart';
import 'package:Ran/ui/float_dialog.dart';
import 'package:Ran/ui/hook/module_list_view.dart';
import 'package:Ran/ui/hook/symbol_home.dart';
import 'package:Ran/ui/hook/symbol_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.FINE; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time} [${record.level.name}]: ${record.loggerName} -  ${record.message}');
  });
  Logger log = Logger("init");
  log.info("trace route mainroot /");
  runApp(MainApp("/"));
}

@pragma('vm:entry-point')
void floatMain() {
  Logger.root.level = Level.FINE; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time} [${record.level.name}]: ${record.loggerName} -  ${record.message}');
  });
  Logger log = Logger("int");
  log.info("trace route floatMain");

  runApp(FloatApp());
}

class FloatApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Inspect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, fontFamily: 'NotoSansCJK'),
        initialRoute: '/floatMain',
        // initialRoute: initialRoute,
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => AppListView(),
          // '/': (context) => MetricView(pkgName: "com.tencent.tmgp.sgame"),
          // '/': (context) => MetricViewAll(),
          // '/': (context) => VerticalGradient(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/floatMain': (context) => FloatDialog(),
        });
  }
}

class MainApp extends StatelessWidget {
  MainApp(this.initialRoute);

  final String initialRoute;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Inspect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, fontFamily: 'NotoSansCJK'),
        initialRoute: '/',
        // initialRoute: initialRoute,
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => AppListView(),
          // '/': (context) => MetricView(pkgName: "com.tencent.tmgp.sgame"),
          // '/': (context) => MetricViewAll(),
          // '/': (context) => VerticalGradient(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/floatMain': (context) => FloatDialog(),
        });
  }
}

// @pragma('vm:entry-point')
// void main_dialog() {
//   runApp(MyDialog());
// }
//
// class MyDialog extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//       ),
//       home: NetRequestDialog(),
//     );
//   }
// }
