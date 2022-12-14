import 'package:flutter/material.dart';
import 'package:push_notification/main.dart';
import 'package:push_notification/page_3.dart';

class NextPage extends StatefulWidget {
  final String? id;
  const NextPage({Key? key, this.id}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_sharp)),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return Page3();
                  // }));

                  navigatorKey.currentState
                      ?.push(MaterialPageRoute(builder: (_) {
                    return Page3();
                  }));
                },
                child: Text("Page 3")),
            Center(
                child: Text(
              widget.id.toString(),
              style: TextStyle(fontSize: 40),
            )),
          ],
        ));
  }
}
