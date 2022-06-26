
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:time_loader/components/selectable_text_button.dart';

class CxkMakerPage extends StatefulWidget {
  const CxkMakerPage({Key? key}) : super(key: key);

  @override
  State<CxkMakerPage> createState() => _CxkMakerPageState();
}

class _CxkMakerPageState extends State<CxkMakerPage> with SingleTickerProviderStateMixin {
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
          windowTitle: '全民练习生',
          text: '练习完毕',
          alertStyle: AlertButtonStyle.ok,
          iconStyle: IconStyle.warning,
        );
      }
        setState(() {});
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
              child: Text('选择今天要练习的项目：'),
            ),
            Row(
              children: [
                SelectableTextButton(child: Text('唱',),),
                SelectableTextButton(child: Text('跳',),),
                SelectableTextButton(child: Text('Rap',),),
                SelectableTextButton(child: Text('篮球',),),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5)
              ),
              child: TextButton(
                onPressed: () {
                  controller.reset();
                  controller.forward();
                },
                child: Text('Music', style: TextStyle(color: Colors.white),),
              ),
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
            Container(height: 10,),
            if (controller.isCompleted)
              Text(
                '恭喜你！！练习完成，练习时长 2 天半！！！',
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
