
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class TimeSaverPage extends StatefulWidget {
  const TimeSaverPage({Key? key}) : super(key: key);

  @override
  State<TimeSaverPage> createState() => _TimeSaverPageState();
}

class _TimeSaverPageState extends State<TimeSaverPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, 
      duration: const Duration(seconds: 5)
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await FlutterPlatformAlert.showAlert(
            windowTitle: '时间储存器',
            text: '储存完毕',
            alertStyle: AlertButtonStyle.ok,
            iconStyle: IconStyle.warning,
          );
          setState(() {});
          // showCupertinoDialog(context: context, builder: (ctx) {
          //   return CupertinoAlertDialog(
          //     title: Text('提取完毕'),
          //     actions: [
          //       CupertinoDialogAction(
          //         isDefaultAction: true,
          //         onPressed: () {
          //           Navigator.pop(ctx);
          //         },
          //         child: Text('确定'),
          //       )
          //     ],
          //   );
          // });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text('可储存时间：'),
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (ctx, child) {
                return LinearProgressIndicator(
                  value: 1 - controller.value * 0.1,
                  backgroundColor: Colors.grey,
                  minHeight: 20,
                );
              }
            ),
            Container(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text('已储存时间：'),
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (ctx, child) {
                return LinearProgressIndicator(
                  value: controller.value,
                  backgroundColor: Colors.grey,
                  minHeight: 20,
                );
              }
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              color: Colors.blue,
              child: TextButton(
                onPressed: () {
                  controller.forward();
                },
                child: Text('开始', style: TextStyle(color: Colors.white),),
              ),
            ),
            if (controller.isCompleted)
              Text(
                '恭喜你！！已储存时间 5 秒！！！',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
