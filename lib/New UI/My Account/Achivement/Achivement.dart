import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vakalat_flutter/helper.dart';

import '../../../color/customcolor.dart';
import '../../../utils/constant.dart';
import 'Add_Achivements.dart';

class Achivement_Screen extends StatefulWidget {
  const Achivement_Screen({Key? key}) : super(key: key);

  @override
  State<Achivement_Screen> createState() => _Achivement_ScreenState();
}

class _Achivement_ScreenState extends State<Achivement_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Add_Achivements(),
                ));
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text('Achivements'),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 12),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 2,
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Const().Textinscreen('Title', 'Case achivement', context),
                      Const().Textinscreen('Month', 'February', context),
                      Const().Textinscreen('Year', '2022', context),
                      Row(
                        children: [
                          SizedBox(
                              width: screenwidth(context, dividedby: 7),
                              child: const Text(
                                'Action',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )),
                          Row(
                            children: [
                              MaterialButton(
                                color: const Color(0xff448BE8),
                                height: 25,
                                minWidth: 25,
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                child: const Icon(
                                  FontAwesomeIcons.edit,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                              MaterialButton(
                                color: const Color(0xffAF3F3F),
                                height: 25,
                                minWidth: 25,
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                child: const Icon(
                                  Icons.delete,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
