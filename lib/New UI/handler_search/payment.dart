import 'package:cc_avenue/cc_avenue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../color/customcolor.dart';
import '../../utils/constant.dart';
import '../../utils/design.dart';

class Payment_Screen extends StatefulWidget {
  final int amount;
  final String name;
  final double gst;
  final double totalamount;

  const Payment_Screen({super.key, required this.amount, required this.gst, required this.totalamount, required this.name});


  @override
  State<Payment_Screen> createState() => _Payment_ScreenState();
}

class _Payment_ScreenState extends State<Payment_Screen> {
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await CcAvenue.cCAvenueInit(
          transUrl: 'https://secure.ccavenue.com/transaction/initTrans',
          accessCode: '4YRUXLSRO20O8NIH',
          amount: '10',
          cancelUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
          currencyType: 'INR',
          merchantId: '2',
          orderId: '519',
          redirectUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
          rsaKeyUrl: 'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp'
      );

    } on PlatformException {
      print('PlatformException');
    }
  }
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
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Container(
                // height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffF4F9FF)),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Const().cartscreen('Item', 'Handler', context),
                      Const().cartscreen('Name', 'MeghalShukla', context),
                      Const().cartscreen('Price', 'Yearly Web Handler Charges', context),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                // height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffF4F9FF)),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Const().cartscreen('Item', 'PACAKGE', context),
                      Const().cartscreen('Name', widget.name, context),
                      Const().cartscreen('Price', '₹${widget.amount}/Year', context),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Order Summary',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Package Basic',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  Text('₹ ${widget.amount}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('GST',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  Text('₹ ${widget.gst}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey),),
                ],
              ),
              const Divider(thickness: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Amount Payable',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  Text('₹ ${widget.totalamount}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black54),),
                ],
              ),
              const SizedBox(height: 20,),
              Button_For_Update_Save(text: 'PAYMENT', onpressed: (){
                initPlatformState();
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_Screen(),));
              }
              )
            ],
          ),
        ),
      ),
    );
  }
}
