import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
class CommonFunctions {


  static String formatDate ( String sourceDateFormat, String destiationDateFormat , String strDateValue )
  {
    // https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
    DateTime tempDate = DateFormat(sourceDateFormat).parse(strDateValue);
    final DateFormat formatter = DateFormat(destiationDateFormat);
    final String formatted = formatter.format(tempDate);
    return formatted;
  }
  static Future<void> makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  static String whatsapp_LawyerContact ( String MobileNumber, String FullName  )
  {
    String strURL = "https://wa.me/91${MobileNumber.trim()}?text=Hello, $FullName\nI am contacting you from your *Vakalat.com* \n\n I want to ";
    var encoded = Uri.encodeFull(strURL);
// print(encoded);
    return encoded;
  }



  static String checkHttp( String strURL)
  {
    String strValue = strURL;
    if (strURL.toLowerCase().contains("http://") || strURL.toLowerCase().contains("https://"))
    {

    }
    else
    {
      strValue = "http://$strURL";
    }

    return strValue;

  }
  static String getGenderName( String gender)
  {
    String strValue = "";
    if (gender.toLowerCase() == "a")
      {
        strValue = "Any";
      }
    else  if (gender.toLowerCase() == "m")
    {
      strValue = "Male";
    }
    else  if (gender.toLowerCase() == "f")
    {
      strValue = "Female";
    }
    return strValue;

  }
  static bool getBoolenName( String strBool)
  {
    bool strValue = false;
    if (strBool.toLowerCase() == "y")
    {
      strValue = true;
    }
    else  if (strBool.toLowerCase() == "n")
    {
      strValue = false;
    }

    return strValue;

  }


}