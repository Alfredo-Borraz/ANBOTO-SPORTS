import 'package:flutter/material.dart';

void viewBottomSheet(BuildContext context, Widget bottomSheetBody) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: const Color(0xffFFECAA),
    context: context,
    builder: (context) {
      return bottomSheetBody;
    },
  );
}
