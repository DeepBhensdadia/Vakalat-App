
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class BA_DownloadsPage extends StatefulWidget {
  const BA_DownloadsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BA_DownloadsPage> createState() => _BA_DownloadsPageState();
}

class _BA_DownloadsPageState extends State<BA_DownloadsPage> with KeyboardHiderMixin {
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
