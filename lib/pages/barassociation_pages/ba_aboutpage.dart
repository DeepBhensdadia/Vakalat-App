
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class BA_AboutPage extends StatefulWidget {
  const BA_AboutPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BA_AboutPage> createState() => _BA_AboutPageState();
}

class _BA_AboutPageState extends State<BA_AboutPage> with KeyboardHiderMixin {
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
