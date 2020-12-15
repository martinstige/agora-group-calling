import '../utils/token_http_client.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'CallPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  bool _validateError = false;
  final PermissionHandler _permissionHandler = PermissionHandler();
  //SystemChrome.setEnabledSystemUIOverlays([]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Kokkehjelp'),
      //   elevation: 0,
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 100)),
            Image(
              image: NetworkImage(
                  'https://www.kokkehjelp.no/img/chef.7e9fb6c7.png'),
              height: 100,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              'Kokkehjelp - video',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Container(
              //padding: EdgeInsets.only(left: 100),
              //width: 300,
              child: TextFormField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Kode',
                  labelStyle: TextStyle(color: Colors.blue),
                  hintText: 'test',
                  hintStyle: TextStyle(color: Colors.black45),
                  errorText:
                      _validateError ? 'Vennligs oppgi tilsendt kode' : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 30)),
            Container(
              // width: 190,
              child: MaterialButton(
                onPressed: onJoin,
                height: 40,
                color: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Koble til',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      myController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    await _permissionHandler.requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);

    final token = await fetchToken(
        myController.text, 'sT0bZ3kTq/dwDgKt14kc5x0mBRD8GAsNli6prNgtg5Tw3eApORkWTw==');

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(token: token),
        ));
  }
}
