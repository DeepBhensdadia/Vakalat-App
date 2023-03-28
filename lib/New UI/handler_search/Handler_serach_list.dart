import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../color/customcolor.dart';
import 'Cart.dart';

class Handler_Serach_list extends StatefulWidget {
  const Handler_Serach_list({Key? key}) : super(key: key);

  @override
  State<Handler_Serach_list> createState() => _Handler_Serach_listState();
}

class _Handler_Serach_listState extends State<Handler_Serach_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Handler Search',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'ONLY FOR LAWYEAR',
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.expand_more,
                    size: 30,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart_Screen(),)),
                            child: Card(
                              margin: EdgeInsets.zero,
                              child: SizedBox(
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Available',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text('Deep Patel',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black))
                                        ],
                                      ),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: CustomColor().colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(child: Icon(FontAwesomeIcons.cartPlus,color: Colors.white,size: 20,)),
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
