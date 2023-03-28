import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../color/customcolor.dart';
import '../../../utils/constant.dart';
import '../Achivement/Add_Achivements.dart';

class Participation extends StatefulWidget {
  const Participation({Key? key}) : super(key: key);

  @override
  State<Participation> createState() => _ParticipationState();
}

class _ParticipationState extends State<Participation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => const Add_Achivements(),));
      },child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text('Participation'),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 2,
            child:
            SizedBox(
              height: 150,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                      Const().Textinscreen('Title', 'Case achivement',context),
                      Const().Textinscreen('Month', 'February',context),
                      Const().Textinscreen('Year', '2022',context),
                      Row(
                        children: [
                          const SizedBox(

                              width: 60,
                              child: Text(
                                'Action',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [

                              MaterialButton(
                                color: const Color(0xff448BE8),
                                height: 30,
                                minWidth: 30,
                                padding: EdgeInsets.zero,
                                onPressed: (){},
                                child: const Icon(FontAwesomeIcons.edit,size: 14,color: Colors.white,),),
                              MaterialButton(
                                color: const Color(0xffAF3F3F),
                                height: 30,
                                minWidth: 30,
                                padding: EdgeInsets.zero,
                                onPressed: (){},
                                child: const Icon(Icons.delete,size: 14,color: Colors.white,),),
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
