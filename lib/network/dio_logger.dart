// ignore_for_file: unnecessary_string_escapes

import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';

class DioLogger extends Interceptor {
  /// InitialTab count to log json response
  static const int kInitialTab = 1;

  /// 1 tab length
  static const String tabStep = '    ';

  /// Size in which the Uint8List will be splitted
  static const int chunkSize = 20;

  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request data [Options.data]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// Print compact json response
  final bool compact;

  /// Width size per log
  final int maxWidth;

  /// Log printer; defaults log log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file.
  final void Function(Object object) logPrint;

  DioLogger(
      {this.request = true,
      this.requestHeader = false,
      this.requestBody = false,
      this.responseHeader = false,
      this.responseBody = true,
      this.error = true,
      this.maxWidth = 90,
      this.compact = true,
      this.logPrint = print});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error) {
      if (err.type == DioExceptionType.badResponse) {
        final uri = err.response?.requestOptions.uri;
        _printBoxed(
            header:
                'DioError ║ Status: ${err.response?.statusCode} ${err.response?.statusMessage}',
            text: "$uri",
            isError: true);
        if (err.response != null && err.response?.data != null) {
          log('\x1b[38;5;9m╔ ${err.type.toString()}');
          _printResponse(err.response!, isError: true);
        }
        _printLine('\x1b[38;5;197m╚');
        log('');
      } else {
        _printBoxed(
            header: '\x1b[38;5;197mDioError ║ ${err.type}', text: err.message);
      }
    }
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (request) {
      _printRequestHeader(options);
    }
    if (requestHeader) {
      _printMapAsTable(options.queryParameters, header: 'Query Parameters');
      final requestHeaders = <String, dynamic>{};

      requestHeaders.addAll(options.headers);
      requestHeaders['contentType'] = options.contentType?.toString();
      requestHeaders['responseType'] = options.responseType.toString();
      requestHeaders['followRedirects'] = options.followRedirects;
      requestHeaders['connectTimeout'] = options.connectTimeout?.toString();
      requestHeaders['receiveTimeout'] = options.receiveTimeout?.toString();
      _printMapAsTable(requestHeaders, header: 'Headers');
      _printMapAsTable(options.extra, header: 'Extras');
    }
    if (requestBody && options.method != 'GET') {
      final dynamic data = options.data;

      if (data != null) {
        if (data is Map) _printMapAsTable(options.data as Map?, header: 'Body');
        if (data is FormData) {
          final formDataMap = <String, dynamic>{}
            ..addEntries(data.fields)
            ..addEntries(data.files);
          _printMapAsTable(formDataMap, header: 'Form data | ${data.boundary}');
        } else {
          _printBlock(data.toString());
        }
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printResponseHeader(response);
    if (responseHeader) {
      final responseHeaders = <String, String>{};
      response.headers
          .forEach((k, list) => responseHeaders[k] = list.toString());
      _printMapAsTable(responseHeaders, header: 'Headers');
    }

    if (responseBody) {
      log('╔ Body');
      log('║');
      _printResponse(response);
      log('║');
      _printLine('╚');
    }
    super.onResponse(response, handler);
  }

  bool _canFlattenList(List list) {
    return list.length < 10 && list.toString().length < maxWidth;
  }

  bool _canFlattenMap(Map map) {
    return map.values
            .where((dynamic val) => val is Map || val is List)
            .isEmpty &&
        map.toString().length < maxWidth;
  }

  String _indent([int tabCount = kInitialTab]) => tabStep * tabCount;

  void _printBlock(String msg, {bool isError = false, bool isHeader = false}) {
    final lines = (msg.length / maxWidth).ceil();
    for (var i = 0; i < lines; ++i) {
      log(isError
          ? "\x1b[38;5;9m${i >= 0 ? '║ ' : ''}${msg.substring(i * maxWidth, math.min<int>(i * maxWidth + maxWidth, msg.length))}"
          : isHeader
              ? "	\x1b[38;5;51m${i >= 0 ? '║ ' : ''}${msg.substring(i * maxWidth, math.min<int>(i * maxWidth + maxWidth, msg.length))}"
              : "\x1b[38;5;76m${i >= 0 ? '║ ' : ''}${msg.substring(i * maxWidth, math.min<int>(i * maxWidth + maxWidth, msg.length))}");
    }
  }

  void _printBoxed({String? header, String? text, bool isError = false}) {
    log('');
    log(isError ? '\x1b[38;5;9m╔╣ $header' : '\x1b[38;5;219m╔╣ $header');
    log(isError ? '\x1b[38;5;9m║  $text' : '\x1b[38;5;219m║  $text');
    _printLine(isError ? '\x1b[38;5;9m╚' : '\x1b[38;5;219m╚');
  }

  void _printKV(String? key, Object? v, {bool isHeader = false}) {
    final pre = '╟ $key: ';
    final msg = v.toString();

    if (pre.length + msg.length > maxWidth) {
      log(isHeader ? "\x1b[38;5;51m$pre" : "\x1b[38;5;76m$pre");
      _printBlock(
        msg,
      );
    } else {
      log(isHeader ? "\x1b[38;5;51m$pre$msg" : '\x1b[38;5;76m$pre$msg');
    }
  }

  void _printLine([String pre = '', String suf = '╝']) =>
      log('$pre${'═' * maxWidth}$suf');

  void _printList(List list, {int tabs = kInitialTab}) {
    list.asMap().forEach((i, dynamic e) {
      final isLast = i == list.length - 1;
      if (e is Map) {
        if (compact && _canFlattenMap(e)) {
          log('║${_indent(tabs)}  $e${!isLast ? ',' : ''}');
        } else {
          _printPrettyMap(e,
              initialTab: tabs + 1, isListItem: true, isLast: isLast);
        }
      } else {
        log('║${_indent(tabs + 2)} $e${isLast ? '' : ','}');
      }
    });
  }

  void _printMapAsTable(Map? map, {String? header}) {
    if (map == null || map.isEmpty) return;
    log('	\x1b[38;5;51m╔ $header ');

    map.forEach(
      (dynamic key, dynamic value) =>
          _printKV(key.toString(), value, isHeader: header != null),
    );
    _printLine('	\x1b[38;5;51m╚');
  }

  void _printPrettyMap(Map data,
      {int initialTab = kInitialTab,
      bool isListItem = false,
      bool isLast = false,
      bool isError = false}) {
    var tabs = initialTab;
    final isRoot = tabs == kInitialTab;
    final initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) {
      log(isError ? '\x1b[38;5;9m║$initialIndent{' : '║$initialIndent{');
    }

    data.keys.toList().asMap().forEach((index, dynamic key) {
      final isLast = index == data.length - 1;
      dynamic value = data[key];
      if (value is String) {
        value = '"${value.toString().replaceAll(RegExp(r'([\r\n])+'), " ")}"';
      }
      if (value is Map) {
        if (compact && _canFlattenMap(value)) {
          log(isError
              ? '\x1b[38;5;9m║${_indent(tabs)} $key: $value${!isLast ? ',' : ''}'
              : '║${_indent(tabs)} $key: $value${!isLast ? ',' : ''}');
        } else {
          log(isError
              ? '\x1b[38;5;9m║${_indent(tabs)} $key: {'
              : '║${_indent(tabs)} $key: {');
          _printPrettyMap(value, initialTab: tabs, isError: isError);
        }
      } else if (value is List) {
        if (compact && _canFlattenList(value)) {
          log(isError
              ? '\x1b[38;5;9m║${_indent(tabs)} $key: ${value.toString()}'
              : '║${_indent(tabs)} $key: ${value.toString()}');
        } else {
          log(isError
              ? '\x1b[38;5;9m║${_indent(tabs)} $key: ['
              : '║${_indent(tabs)} $key: [');
          _printList(value, tabs: tabs);
          log(isError
              ? '\x1b[38;5;9m║${_indent(tabs)} ]${isLast ? '' : ','}'
              : '║${_indent(tabs)} ]${isLast ? '' : ','}');
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        final indent = _indent(tabs);
        final linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          final lines = (msg.length / linWidth).ceil();
          for (var i = 0; i < lines; ++i) {
            log(isError
                ? '\x1b[38;5;9m║${_indent(tabs)} ${msg.substring(i * linWidth, math.min<int>(i * linWidth + linWidth, msg.length))}'
                : '║${_indent(tabs)} ${msg.substring(i * linWidth, math.min<int>(i * linWidth + linWidth, msg.length))}');
          }
        } else {
          log(isError
              ? '\x1b[38;5;9m║${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}'
              : '║${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}');
        }
      }
    });

    log(isError
        ? '\x1b[38;5;9m║$initialIndent}${isListItem && !isLast ? ',' : ''}'
        : '║$initialIndent}${isListItem && !isLast ? ',' : ''}');
  }

  void _printRequestHeader(RequestOptions options) {
    final uri = options.uri;
    final method = options.method;
    _printBoxed(header: '\x1b[38;5;219m ║ $method ', text: uri.toString());
  }

  void _printResponse(Response response, {bool isError = false}) {
    if (response.data != null) {
      if (response.data is Map) {
        _printPrettyMap(response.data as Map, isError: isError);
      } else if (response.data is Uint8List) {
        log('║${_indent()}[');
        _printUint8List(response.data as Uint8List);
        log('║${_indent()}]');
      } else if (response.data is List) {
        log('║${_indent()}[');
        _printList(response.data as List);
        log('║${_indent()}]');
      } else {
        _printBlock(response.data.toString(), isError: isError);
      }
    }
  }

  void _printResponseHeader(Response response) {
    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;
    _printBoxed(
        header:
            'Response ║ $method ║ Status: ${response.statusCode} ${response.statusMessage}',
        text: uri.toString());
  }

  void _printUint8List(Uint8List list, {int tabs = kInitialTab}) {
    var chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(
            i, i + chunkSize > list.length ? list.length : i + chunkSize),
      );
    }
    for (var element in chunks) {
      log('║${_indent(tabs)} ${element.join(", ")}');
    }
  }
}
