
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class LawyerContactPage extends StatefulWidget {
  const LawyerContactPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LawyerContactPage> createState() => _LawyerContactPageState();
}

class _LawyerContactPageState extends State<LawyerContactPage> with KeyboardHiderMixin {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: CustomColor().colorPrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return Container();
  }
}