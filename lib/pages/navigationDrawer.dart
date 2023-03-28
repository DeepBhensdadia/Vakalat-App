import 'package:vakalat_flutter/model/clsUser.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/widgets/createDrawerHeader.dart';
import 'package:vakalat_flutter/widgets/createDrawerBodyItem.dart';

class navigationDrawer extends StatelessWidget {
  late BuildContext context;

  navigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          createDrawerHeader(),
          createDrawerBodyItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              }),
          createDrawerBodyItem(
              icon: Icons.list,
              text: 'Details',
              onTap: () {
                gotoGroups();
                Scaffold.of(context).openEndDrawer();
              }),
          // createDrawerBodyItem(
          //     icon: Icons.filter_list,
          //     text: 'Filter',
          //     onTap: () {
          //       gotoFilter();
          //       Scaffold.of(context).openEndDrawer();
          //     }),
          const Divider(),
          createDrawerBodyItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                showAlertDialog(context);
              }),
          ListTile(
            title: const Text('App version 1.0'),
            onTap: () {},
          ),
          // createDrawerBodyItem(
          //     icon: Icons.table_chart,
          //     text: 'Test',
          //     onTap: () {
          //       gotoTestPage();
          //     }),
        ],
      ),
    );
  }



  void gotoLogin() {
    logout();
    Navigator.of(context).pushReplacementNamed("/login");
  }

  void gotoGroups() {
    Navigator.of(context).pushReplacementNamed("/view");
  }

  Future logout() async {
    Const.currentUser = clsUser();
    Const.currentUser?.clearLoginPrefrences();

  }


  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        gotoLogin();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Would you like to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
