import 'dart:convert';
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logPrint = print,
  });

  @override
  bool request;
  bool requestHeader;
  bool requestBody;
  bool responseBody;
  bool responseHeader;
  bool error;
  void Function(Object object) logPrint;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logPrint('╭--------------- Request---------------------------------');
    _printKV('| CURL', toCurlCmd(options));
    _printKV('| Uri', options.uri);
    //options.headers;

    if (request) {
      _printKV('| Method', options.method);
      _printKV('| EsponseType', options.responseType.toString());
      _printKV('| FollowRedirects', options.followRedirects);
      _printKV('| ConnectTimeout', options.connectTimeout);
      _printKV('| SendTimeout', options.sendTimeout);
      _printKV('| ReceiveTimeout', options.receiveTimeout);
      _printKV(
          '| ReceiveDataWhenStatusError', options.receiveDataWhenStatusError);
      _printKV('| Extra', options.extra);
    }
    if (requestHeader) {
      logPrint('| Headers:');
      options.headers.forEach((key, v) => _printKV('|     $key', v));
    }
    if (requestBody) {
      if (options.data != null) {
        if (options.data is FormData) {
          Map<String, dynamic> files = {};
          String postData = "";

          FormData fdata = options.data as FormData;
          for (var element in fdata.files) {
            MultipartFile file = element.value;
            files[element.key] = "@${file.filename}";
          }
          for (var element in fdata.fields) {
            files[element.key] = element.value;
          }
          if (files.isNotEmpty) {
            postData = files
                .map((key, value) => MapEntry(key, "'$key=$value'"))
                .values
                .join(" ");
            _printKV('| Data', postData);
          }
        } else {
          logPrint('| Data:');
          _printAll(options.data);
        }
      }
    }
    logPrint('╰--------------> End Request-----------------------------');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    logPrint('╭--------------- Response---------------------------------');
    _printResponse(response);
    logPrint('╰--------------> End Response-----------------------------');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (error) {
      logPrint('*** DioError ***:');
      logPrint('uri: ${err.requestOptions.uri}');
      logPrint('$err');
      if (err.response != null) {
        _printResponse(err.response!);
      }
      logPrint('');
    }

    handler.next(err);
  }

  String toCurlCmd(RequestOptions options) {
    String cmd = "curl";

    String header = options.headers
        .map((key, value) {
          if (key == "content-type" &&
              value.toString().contains("multipart/form-data")) {
            value = "multipart/form-data;";
          }
          return MapEntry(key, "-H '$key: $value'");
        })
        .values
        .join(" ");

    // String url = "${options.baseUrl}${options.path}";
    String url = options.path;
    if (options.queryParameters.isNotEmpty) {
      String query = options.queryParameters
          .map((key, value) {
            return MapEntry(key, "$key=$value");
          })
          .values
          .join("&");

      url += (url.contains("?")) ? query : "?$query";
    }
    if (options.method == "GET") {
      cmd += " $header '$url'";
    } else {
      Map<String, dynamic> files = {};
      String postData = "-d ''";
      if (options.data != null) {
        if (options.data is FormData) {
          FormData fdata = options.data as FormData;
          fdata.files.forEach((element) {
            MultipartFile file = element.value;
            files[element.key] = "@${file.filename}";
          });
          fdata.fields.forEach((element) {
            files[element.key] = element.value;
          });
          if (files.isNotEmpty) {
            postData = files
                .map((key, value) => MapEntry(key, "-F '$key=$value'"))
                .values
                .join(" ");
          }
        } else if (options.data is Map<String, dynamic>) {
          files.addAll(options.data);

          if (files.isNotEmpty) {
            postData = "-d '${json.encode(files).toString()}'";
          }
        }
      }

      String method = options.method.toString();
      cmd += " -X $method $postData $header '$url'";
    }

    return cmd;
  }

  void _printResponse(Response response) {
    _printKV('| Uri', response.requestOptions.uri);
    if (responseHeader) {
      _printKV('| StatusCode', response.statusCode);
      if (response.isRedirect == true) {
        _printKV('| Redirect', response.realUri);
      }

      logPrint('| Headers:');
      response.headers
          .forEach((key, v) => _printKV('|     $key', v.join('\r\n\t')));
    }
    if (responseBody) {
      logPrint('| Response Text:');
      _printAll(response.toString());
    }
  }

  void _printKV(String key, Object? v) {
    logPrint('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }
}
