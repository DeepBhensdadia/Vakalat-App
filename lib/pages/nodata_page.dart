
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';


class NoDataPage extends StatefulWidget {
  const NoDataPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NoDataPage> createState() => _NoDataPageState();
}

class _NoDataPageState extends State<NoDataPage> with KeyboardHiderMixin {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/noimage.png'),
          const Text(
            'No Data Found.',
            style: TextStyle(fontSize: 20.0),
          )
        ],
      ),
    ) ;
  }

}
