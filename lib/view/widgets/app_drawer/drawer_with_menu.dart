import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWithMenu extends StatelessWidget {
  const DrawerWithMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Navigate to Home page
            },
          ),
          ExpansionTile(
            title: Text('Products'),
            children: [
              ListTile(
                title: Text('Product 1'),
                onTap: () {
                  // Handle Product 1 tap
                },
              ),
              ListTile(
                title: Text('Product 2'),
                onTap: () {
                  // Handle Product 2 tap
                },
              ),
            ],
          ),
          // Add more list tiles or expansion tiles as needed
        ],
      ),
    );
  }
}
