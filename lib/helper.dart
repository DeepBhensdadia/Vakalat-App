import 'package:flutter/material.dart';

Size screensize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenheight(BuildContext context, {double dividedby = 1}) {
  return screensize(context).height / dividedby;
}

double screenwidth(BuildContext context, {double dividedby = 1}) {
  return screensize(context).width / dividedby;
}
