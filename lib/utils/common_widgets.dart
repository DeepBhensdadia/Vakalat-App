import 'package:flutter/material.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
class CommonWidgets {

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