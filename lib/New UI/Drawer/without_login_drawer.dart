import 'package:flutter/material.dart';

import '../../pages/profilepage.dart';

class Without_login_Drawer extends StatefulWidget {
  const Without_login_Drawer({Key? key}) : super(key: key);

  @override
  State<Without_login_Drawer> createState() => _Without_login_DrawerState();
}

class _Without_login_DrawerState extends State<Without_login_Drawer> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfilePage(title: '',),
    );
  }
}
