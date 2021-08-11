// import 'dart:html';

import 'package:Ran/generated/android_manager.pbgrpc.dart';
import 'package:Ran/generated/app_manager.pb.dart';
import 'package:Ran/generated/root_manager.pb.dart';
import 'package:Ran/rpc/hook_grpc_client.dart';
import 'package:Ran/rpc/root_grpc_client.dart';
import 'package:logging/logging.dart';
import '../rpc/grpc_client.dart';
import 'package:grpc/grpc.dart';
import 'package:fixnum/fixnum.dart';

class UiState {
  static bool is_vpn_on = false;
  static Logger log = Logger("UiState");

  static List<PackageInfo>? package_list_cache;

  static Future<List<HookInfo>> hookInfoList() {
    log.info("hookInfoList");
    var req = HookInfoListReq();

    var resp =
        HookGrpcClient.grpcClient.hookInfoList(req, options: CallOptions());
    return resp.then((result) {
      return result.hooks;
    });
  }

  static Future<int> hookInfoAdd(HookInfo info) {
    log.info("hookInfoAdd");

    var req = HookInfoAddReq();
    req.info = info;
    var resp =
        HookGrpcClient.grpcClient.hookInfoAdd(req, options: CallOptions());
    return resp.then((result) {
      return result.status;
    });
  }

  static Future<List<ModuleInfo>> hookListModules(String pkgName) {
    log.info("hookListModules for $pkgName");
    var req = HookListModulesReq();
    req.pkgName = pkgName;

    var resp =
        HookGrpcClient.grpcClient.hookListModules(req, options: CallOptions());

    return resp.then((result) {
      return result.modules;
    });
  }

  static Future<List<HookSymbolInfo>> hookListSymbols(String moduleName) {
    log.fine("hookListSymbols for $moduleName");
    var req = HookListSymbolsReq();
    req.moduleName = moduleName;

    var resp =
        HookGrpcClient.grpcClient.hookListSymbols(req, options: CallOptions());

    return resp.then((result) {
      return result.symbols;
    });
  }

  static Future<List<PackageInfo>> fetchPackageList(bool forceRefresh) {
    log.fine("fetchPackageList, forceRefresh:$forceRefresh");
    var req = PackageInfoReq();
    req.notSystemApp = true;

    if (!forceRefresh && package_list_cache != null) {
      log.fine("fetchPackageList from cache!");
      return Future.value(package_list_cache);
    } else {
      var resp = GrpcClient.grpcClient.listPackage(req,
          options: CallOptions(timeout: Duration(seconds: 30)));
      return resp.then((result) {
        // UiState.package_list_cache = result.pkgInfoList; //.take(10).toList();
        package_list_cache = result.pkgInfoList;
        log.info("fetchPackageList from rpc!");

        return result.pkgInfoList;
      });
    }

    // if (UiState.package_list_cache == null) {
    //   print("_fetchPackageList: no cache");
    //   var req = PackageInfoReq();
    //   req.notSystemApp = true;
    //   var resp = GrpcClient.grpcClient.listPackage(req, options: CallOptions());
    //   return resp.then((result) {
    //     UiState.package_list_cache = result.pkgInfoList; //.take(10).toList();
    //     return UiState.package_list_cache!;
    //   });
    // } else {
    //   print("_fetchPackageList: cached");
    //   return Future.value(UiState.package_list_cache!);
    // }
    // return resp.pkgInfoList;
  }

  // static Future<String> killApp(String pkgName) {
  //   var req = AppControlReq.create();
  //   req.pkgName = pkgName;
  //   req.cmd = "kill";
  //   var resp = GrpcClient.grpcClient.appControl(req);
  //   return resp.then((result) => result.status);
  // }

  static Future<String> reStartAppWithDebug(String pkgName) async {
    var res1 = await runRootCmd("am force-stop $pkgName");
    var res2 = await runRootCmd("touch /data/data/$pkgName/.parasite");
    var res3 = await runRootCmd("monkey -p $pkgName 1");
    return Future.value("$res1, $res2, $res3");
  }

  static Future<String> runRootCmd(String cmd) {
    log.info("runRootCmd: $cmd");
    var req = RunRootCmdReq.create();
    req.cmd = cmd;
    var resp = RootGrpcClient.grpcClient.runRootCmd(req);
    return resp.then((result) => result.result);
  }

  //hook_dump_mem_range
  static Future<String> dumpMemRange(Int64 start, Int64 end, String name) {
    log.info("dumpMemRange: $start-$end");
    var req = HookDumpMemRangeReq.create();

    req.start = start;
    req.end = end;
    req.name = name;

    var resp = HookGrpcClient.grpcClient.hookDumpMemRange(req);
    return resp.then((result) => result.dumpFileOnDevice);
  }

  // static Future<List<String>> loadSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var apps = prefs.getStringList("apps") ?? <String>[];
  //   print("_loadSharedPreferences found ${apps} ");
  //   return apps;
  // }

  // static Future<void> updateSharedPreferences(List<String> apps) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList("apps", apps);
  //   // var apps = prefs.getStringList("apps");
  //   // var res = (apps ?? <String>[]).contains(pkg);
  //   // return Future.value(res);
  // }
}
