import 'package:flutter/material.dart';

import '../../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   elevation: 0,
      // ),
      body: Stack(children: [
        Container(
          width: deviceSize.width,
          height: deviceSize.height,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(48, 52, 61, 1.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: deviceSize.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const LoginForm(),
              ],
            ),
          ),
        ),
        // Positioned(
        //   top: deviceSize.height / 5, //2.5 => center
        //   left: deviceSize.width / deviceSize.width <= 428
        //       ? 30
        //       : 3.5, //2-5 => center
        //   child:
        // ),
      ]),
    );
  }
}
