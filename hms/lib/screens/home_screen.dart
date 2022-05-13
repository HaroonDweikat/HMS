import 'package:flutter/material.dart';
import 'package:hms/widgets/app_drawer.dart';

import 'auth/home_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HMS"),
      ),
      drawer: const AppDrawer(),
      body: const HomeItemsScreen(),
    );
  }
}
