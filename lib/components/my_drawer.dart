import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';


class MyDrawer extends StatelessWidget {
  final bool value; final void Function(bool)? onChanged;
  MyDrawer({super.key, required this.value, required this.onChanged,});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Center(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12)
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Change Theme"),
                    Switch(
                      activeColor: Theme.of(context).colorScheme.primary,
                      activeTrackColor: Theme.of(context).colorScheme.onSurface,
                      value: value,
                      onChanged: onChanged
                    ),
                  ],
              ),
          ),
        )
      )
    );
  }
}
