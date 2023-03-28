
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';


class BarAssociationPage extends StatefulWidget {
  const BarAssociationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BarAssociationPage> createState() => _BarAssociationPageState();
}

class _BarAssociationPageState extends State<BarAssociationPage> with KeyboardHiderMixin {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return widget_nodata();
  }

  Widget widget_nodata()
  {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              elevation: 4,
              child:Image.asset('assets/images/nodata_search.png')),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "No data found.",
              style:  TextStyle(
                  color: CustomColor().colorPrimary,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

}
