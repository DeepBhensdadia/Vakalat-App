
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class BA_MembersPage extends StatefulWidget {
  const BA_MembersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BA_MembersPage> createState() => _BA_MembersPageState();
}

class _BA_MembersPageState extends State<BA_MembersPage> with KeyboardHiderMixin {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
