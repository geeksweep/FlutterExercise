import 'package:acmebank/Navigation/Routes/app_route_constants.dart';
import 'package:acmebank/Widgets/Home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../Utils/acmetheme.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String _loginUserName = '';
  bool _isHidden = true;

  void togglePassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(
                color: AcmeTheme.blueberry, fontSize: 25)),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Padding(
              //TODO: center login elements based on screen height/proportional height
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  //TODO: add child image/logo
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AcmeTheme.blueberry),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AcmeTheme.blueberry)),
                    labelText: 'Username',
                    hintText: 'Enter Username'),
                onChanged: (text) {
                  _loginUserName = text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: _isHidden,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AcmeTheme.blueberry),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AcmeTheme.blueberry)),
                    labelText: 'Password',
                    hintText: 'Enter password',
                    suffixIcon: GestureDetector(
                        onTap: togglePassword,
                        //Image.asset('assets/accounts.png', height: 30, width: 30),
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          child: const Image(
                            image: AssetImage('assets/eye.png'),
                            height: 20,
                            width: 20,
                          ),
                        ))),
              ),
            ),
            // TODO: add "forgot password ?" text here with route
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 250,
              // TODO: Add Container with shadow here or change style to Elevated
              child: TextButton(
                onPressed: ()  {
                   //context.go('/homescreen', extra: _loginUserName);
                   Navigator.push(context, MaterialPageRoute(builder: (_) => 
                                           Homescreen(username: _loginUserName,)));
                },
                style: AcmeTheme.flatButtonStyle(),
                child: const Text(
                  'Login',
                ),
              ),
            ),
            // TODO: add text for new user sign up
          ],
        ),
      ),
    );
  }
}
