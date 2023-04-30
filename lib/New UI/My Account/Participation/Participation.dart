import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vakalat_flutter/model/getParticipation.dart';

import '../../../color/customcolor.dart';
import '../../../utils/constant.dart';
import '../Achivement/Add_Achivements.dart';

class Partocipation_myacc extends StatefulWidget {
  final GetParticipation value;
  const Partocipation_myacc({Key? key, required  this.value}) : super(key: key);

  @override
  State<Partocipation_myacc> createState() => _Partocipation_myaccState();
}

class _Partocipation_myaccState extends State<Partocipation_myacc> {
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
        itemCount: widget.value.participations.length,
        itemBuilder: (context, index) {
          Participation participation = widget.value.participations[index];
          return Padding(
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
                  child: CachedNetworkImage(
                    imageUrl: Const().URL_participation_image +
                        participation.achievementCoverImage,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(

                              image: imageProvider,
                              fit: BoxFit.cover,
                              // colorFilter:
                              //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        Image.asset('assets/images/loading.gif'),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/default.png'),
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
                      Const().Textinscreen('Title', participation.achievementBody,context),
                      Const().Textinscreen('Month', participation.achievementMonth,context),
                      Const().Textinscreen('Year', participation.achievementYear,context),
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
        );
        },
      ),
    );
  }
}
