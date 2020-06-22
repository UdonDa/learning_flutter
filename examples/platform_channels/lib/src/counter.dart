import 'package:flutter/services.dart';

class Counter {
  static MethodChannel methodChannel = const MethodChannel('methodChannelDemo');

  static Future<int> increment({int counterValue}) async {
    final result = await methodChannel.invokeMethod<int>('increment', {'count': counterValue});
    return result;
  }

  static Future<int> decrement({int counterValue}) async {
    final result = await methodChannel.invokeMethod('decrement', {'count': counterValue});
    return result;
  }
}