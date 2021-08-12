import 'package:Ran/ui/app_list.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Inspect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple, fontFamily: 'NotoSansCJK'),
      home: AppListView(),
      // home: SymbolListView(
      //   moduleName: "libc.so",
      // )
      // home: ModuleListView(
      //   pkgName: 'com.example.apprs',
      // ),
      // home: SymbolHome(
      //   moduleName: "libnative-lib.so",
      //   symbolName: "Java_com_example_apprs_MainActivity_stringFromJNI",
      // )
      // initialRoute: '/netreq',
      // initialRoute: '/',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   // '/': (context) => AppInstalledView(),
      //   '/': (context) => AppInstalledView(),
      //   // '/': (context) => MetricView(pkgName: "com.tencent.tmgp.sgame"),
      //   // '/': (context) => MetricViewAll(),
      //   // '/': (context) => VerticalGradient(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   // '/netreq': (context) => FwDialog(),
      // },
      // home: LiveLineChart(),
      // home: ChartView(),
      // home: AppListView(),
    );
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
