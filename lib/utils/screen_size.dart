import 'package:flutter/material.dart';

Size screenSize(BuildContext context) => MediaQuery.of(context).size;

double screenWidth(
  BuildContext context, {
  double dividedBy = 1,
  double reducedBy = 0.0,
}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

double screenHeight(
  BuildContext context, {
  double dividedBy = 1,
  double reducedBy = 0.0,
}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenHeightExcludingToolbar(
  BuildContext context, {
  double dividedBy = 1,
}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}
