import 'package:flutter/material.dart';

class AppDrawerListTile extends StatelessWidget {
  final int itemIndex;
  const AppDrawerListTile({super.key, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
      child: ListTile(
        leading: const Icon(Icons.circle),
        title: Text("item $itemIndex"),
      ),
    );
  }
}
