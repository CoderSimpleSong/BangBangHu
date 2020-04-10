

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'showStr.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "showStr":(context) =>ShowStringWidget(),
      },
      title: "项目切换时的名称",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter与Native通信"),
        ),
        body: BodyWidget(),
        
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  // This widget is the root of your application.
  
  final List<String> titleList = ["调用原生等待框","调用原生Toast并传参","Flutter调用原生界面并传参"];

  final lsyx = MethodChannel('samples.flutter.io/lsyx');
  

  @override
  Widget build(BuildContext context) {
    // 1
    // Navigator.of(context).pushNamed("routeName",arguments: 1);
    // 2
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => ShowStringWidget(),
    // ));


    return ListView.builder(
        itemExtent:80,
        itemCount: titleList.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints.expand(),
            child: RaisedButton(
                color: Colors.blue,
                child: Text("${titleList[index]}",style: TextStyle(fontSize: 20,)),
                textColor: Colors.white,
                onPressed: (){
                  if(index == 0){
                    _showHudMethod();
                  }else if(index == 1){
                    _showToastMethod();
                  }else{
                    _showNewVCMethod(context);
                  }
                },
              ),
          );
        },
      );
  }

  Future<Null> _showHudMethod() async {
    try {
      int result = await lsyx.invokeMethod('showHud');
      
    } on PlatformException catch (e) {
      // batteryLevel = "Failed to get battery level: '${e.message}'.";
      print("${e.message}");
    }
  } 
  Future<Null> _showToastMethod() async {
    try {
      await lsyx.invokeMethod('showToast',"我是flutter传入的提示文字");
    } on PlatformException catch (e) {
      // batteryLevel = "Failed to get battery level: '${e.message}'.";
      print("${e.message}");
    }
  } 
  Future<Null> _showNewVCMethod(BuildContext cc) async {
    try {
      final int result = await lsyx.invokeMethod('pushNewVC',"flutter-ios");
      showDialog(
        context: cc,
        builder: (cc){
          return AlertDialog(
            title: Text('接收到的返回值'),
            content: Text('$result'),
            actions: <Widget>[
              FlatButton(child: Text('取消'),onPressed: (){},),
              FlatButton(child: Text('确认'),onPressed: (){},),
            ],
          );
        }
      );
    } on PlatformException catch (e) {
      // batteryLevel = "Failed to get battery level: '${e.message}'.";
      print("${e.message}");
    }
  } 

}

