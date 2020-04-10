import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ShowStringWidget extends StatefulWidget {
  @override
  _ShowStringWidgetState createState() => _ShowStringWidgetState();
}

class _ShowStringWidgetState extends State<ShowStringWidget> {

  var shouldShowStr;
  // 注册一个通知
    EventChannel eventChannel = const EventChannel('samples.flutter.io/pushFlutterWidget');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventChannel.receiveBroadcastStream(123456).listen(_onEvent,onError: _onError);
  }

    // 回调事件
  void _onEvent(Object event) {
    setState(() {
      shouldShowStr =  event.toString();
    });
  }
  // 错误返回
  void _onError(Object error) {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("$shouldShowStr",style: TextStyle(backgroundColor:Colors.white,color: Colors.orange ,fontSize: 25)),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: Colors.white
      )
    );
  }
}
