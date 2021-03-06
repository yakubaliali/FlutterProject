import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management/helper/http_helper.dart';
import 'package:hospital_management/helper/patientget.dart';
import 'package:hospital_management/main.dart';
import 'package:hospital_management/model/user_payload.dart';
import 'package:hospital_management/utils/routes.dart';

import 'home.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _http = HttpHelper();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  login() async {
    String username = _usernameController.value.text;
    String password = _passwordController.value.text;
    var user = Login(username: username, password: password);
    print(user);

    signIn(user).then((res) {
      Map<String, dynamic> map = jsonDecode(res.body);

      print(res.body);
      if (map['accessToken'] != null) {
        Fluttertoast.showToast(
            msg: "Login Sucsess",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Login"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  child: const Text(
                    'User Login',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  )),
              Container(
                padding: const EdgeInsets.all(30),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: "Type your username"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: "Type your password"),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextButton(
                onPressed: () {
//forgot password screen
                },
                child: const Text(
                  'Forgot Password?',
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w900),
                    ),
                    onPressed: () {
                      print(_usernameController.text);
                      print(_passwordController.text);
                      login();
                    },
                  )),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.signupRoute);
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }

//   Future<void> loginUser() async {
//     String username = _usernameController.value.text;
//     String password = _passwordController.value.text;
//
//     var model = Login(username: username, password: password);
//
//     String _body = jsonEncode(model.toMap());
//
//     try {
//       final response =
//           await _http.postData(getUser, _body);
//           print(response.toString());
//
//       Navigator.pushNamed(context, MyRoutes.homeRoute);
//
//       // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyRoutes.homeRoute));
//
//     } catch (e) {
//       log(e.toString());
//       Fluttertoast.showToast(
//           msg: "$e",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//   }
// }
}