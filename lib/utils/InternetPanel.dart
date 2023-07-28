import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/utils/ToastMessage.dart';

class InternetPanel {
  Widget show({void Function()? callback, bool? isServerError}) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            isServerError == true ? Icons.info : Icons.signal_wifi_off,
            size: 30,
          ),
          const SizedBox(height: 15),
          isServerError == true
              ? Text(
                  'Server Error! Try Again Later',
                  style: GoogleFonts.openSans(),
                )
              : Text(
                  'Opp! There is no Internet Connection',
                  style: GoogleFonts.openSans(),
                ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor().colorPrimary,
            ),
            onPressed: () async {
              //To call the method from parent class use .call function

              callback!.call();
            },
            child: Text(
              "Refresh",
              style: GoogleFonts.openSans(),
            ),
          ),
        ],
      ),
    );
  }

  checkInternetconnection() async {
    dynamic result = await Connectivity().checkConnectivity();
    bool isConnect = false;

    if (result == ConnectivityResult.none) {
      ToastMessage().showmessage("Please check your internet connection");
      isConnect = false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      isConnect = true;
    }

    return isConnect;
  }
}
