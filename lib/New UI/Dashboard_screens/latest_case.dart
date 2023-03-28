import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Latest_Case extends StatefulWidget {
  const Latest_Case({Key? key}) : super(key: key);

  @override
  State<Latest_Case> createState() => _Latest_CaseState();
}

class _Latest_CaseState extends State<Latest_Case> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
        child: Card(
          margin: EdgeInsets.zero,
          child: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '1425 cheque bonus',style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.call,size: 14,),
                          SizedBox(width: 5,),
                          Text('Deep Patel - 9328143230',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black54)),

                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.yellow,
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text('in process',style: TextStyle(fontSize: 12,color: Colors.green),),
                        ),
                      ),
                      Row(

                        children: const [
                          Icon(FontAwesomeIcons.calendar,size: 14,),
                          SizedBox(width: 5,),
                          Text('30 jan 2021',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),

                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
