import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';

class NavWheel extends StatelessWidget {
  const NavWheel({super.key});

  Widget _buildCircle(BuildContext context) {
    final circularMenu = CircularMenu(items: [
      CircularMenuItem(
          color: Colors.blue,
          iconColor: Colors.white,
          iconSize: 30.0,
          margin: 10.0,
          padding: 10.0,
          icon: Icons.home,
          onTap: () {
            // callback
          }),
      CircularMenuItem(
          icon: Icons.search,
          onTap: () {
            //callback
          }),
      CircularMenuItem(
          icon: Icons.settings,
          onTap: () {
            //callback
          }),
      CircularMenuItem(
          icon: Icons.star,
          onTap: () {
            //callback
          }),
      CircularMenuItem(
          icon: Icons.pages,
          onTap: () {
            //callback
          }),
    ]);
    return circularMenu;
  }

  @override
  Widget build(BuildContext context) {
    return _buildCircle(context);
  }
}
