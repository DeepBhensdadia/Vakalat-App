import 'package:flutter/material.dart';


Widget createDrawerHeader() {
  return Container(
      child: DrawerHeader(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                  child: Image.asset(
                'assets/images/logo.png',
                height: 100,
                width: 100,
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.fitWidth,
              )),
              Container(
                  child: const Text("Welcome, User " "",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)))
            ],
          )));
}
