import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Frind!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            // onTap: () => Navigator.of(context)
            //     .pushReplacementNamed(OrdersScreen.routeName),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Mange Product'),
              onTap: () {}),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              }),
        ],
      ),
    );
  }
}
