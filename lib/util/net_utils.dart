import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:gwvideo/api/api.dart';
import 'package:path_provider/path_provider.dart';

Map<String, dynamic> optHeader = {
  'accept-language': 'zh-Hans-CN;q=1, en-CN;q=0.9',
  'content-type': 'application/json',
  'User-Agent': 'SPin/2.1.5 (iPhone; iOS 12.0; Scale/2.00)',
  'Accept-Encoding':'br, gzip, deflate',
  'Connection':'keep-alive',
  'Cookie':'xxx_api_auth=6566323666636138623532656539386234383165656465633939356261393663',
  'Accept':'*/*'
};

var dio = new Dio(BaseOptions(connectTimeout: 30000, headers: optHeader));

class NetUtils {
  static Future get(String url, [Map<String, dynamic> params]) async {
    url = url + '&_t=' + DateTime.now().millisecondsSinceEpoch.toString() +
        '&s_device_id=' + Api.s_device_id + '&s_os_version=' + Api.s_os_version +
    '&s_platform=' + Api.s_platform;
    var response;

    // 设置代理 便于本地 charles 抓包
     (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
         (HttpClient client) {
       client.findProxy = (uri) {
         return "PROXY 192.168.31.126:8888";
       };
     };

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
//    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
//    dio.interceptors.add(CookieManager(cookieJar))
//    dio
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  static Future post(String url, Map<String, dynamic> params) async {
    // // 设置代理 便于本地 charles 抓包
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 30.10.24.79:8889";
    //   };
    // };
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
    var response = await dio.post(url, data: params);
    return response.data;
  }
}
