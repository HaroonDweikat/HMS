// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hms/screens/gaz_pullution_screen.dart';
import 'package:hms/screens/home_screen.dart';
import 'package:hms/screens/auth/login.dart';
import 'package:hms/screens/outdoor_light_screen.dart';
import 'package:hms/screens/soil_pump_screem.dart';
import 'package:hms/theme/theme_constants.dart';
import 'package:hms/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/pump_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HMS',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        PumpScreen.routeName: (ctx) => const PumpScreen(),
        OutdoorScreen.routeName: (ctx) => const OutdoorScreen(),
        SoilPumpScreen.routeName: (ctx) => const SoilPumpScreen(),
        GasPolutionSystem.routeName: (ctx) => const GasPolutionSystem(),
        // ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
      },
    );
  }
}

// class MyHomeScreen extends StatefulWidget {
//   const MyHomeScreen({Key? key}) : super(key: key);

//   @override
//   _MyHomeScreenState createState() => _MyHomeScreenState();
// }

// class _MyHomeScreenState extends State<MyHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     TextTheme _textTheme = Theme.of(context).textTheme;
//     bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text("HMS"),
//         actions: [
//           Switch(
//               value: _themeManager.themeMode == ThemeMode.dark,
//               onChanged: (newValue) {
//                 _themeManager.toggleTheme(newValue);
//               })
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 "assets/imgs/logo.png",
//                 width: 200,
//                 height: 200,
//               ),
//               addVerticalSpace(10),
//               Text(
//                 "Your Name",
//                 style: _textTheme.headline4?.copyWith(
//                     color: isDark ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.bold),
//               ),
//               addVerticalSpace(10),
//               Text(
//                 "@yourusername",
//                 style: _textTheme.subtitle1,
//               ),
//               addVerticalSpace(10),
//               const Text(
//                 "This is a simple Status",
//               ),
//               addVerticalSpace(20),
//               const TextField(),
//               addVerticalSpace(20),
//               ElevatedButton(child: const Text("Just Click"), onPressed: () {}),
//               addVerticalSpace(20),
//               ElevatedButton(child: const Text("Click Me"), onPressed: () {}),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Theme(
//         data: Theme.of(context).copyWith(splashColor: Colors.blue), // For Test
//         child: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {},
//         ),
//       ),
//     );
//   }
// }
