
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class BA_NoticeBoardPage extends StatefulWidget {
  const BA_NoticeBoardPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BA_NoticeBoardPage> createState() => _BA_NoticeBoardPageState();
}

class _BA_NoticeBoardPageState extends State<BA_NoticeBoardPage> with KeyboardHiderMixin {
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
