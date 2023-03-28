
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class BA_EvePage extends StatefulWidget {
  const BA_EvePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BA_EvePage> createState() => _BA_EvePageState();
}

class _BA_EvePageState extends State<BA_EvePage> with KeyboardHiderMixin {
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
