import 'package:flutter/material.dart';
import 'package:rango_mino/core/color.dart';

const appBar = TextStyle(
  color: ThemeColor.primary,
  fontSize: 20,
  fontWeight: FontWeight.bold
);

const textButtonPrimary = TextStyle(
  color: ThemeColor.grey100,
);

const labelStyle = TextStyle(
  color: ThemeColor.grey150,
  fontSize: 16,
  fontWeight: FontWeight.w500
);

const inputStyle = TextStyle(
  color: ThemeColor.grey50,
  fontSize: 16,
  fontWeight: FontWeight.w500
);

final textFieldStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(7),
  borderSide: const BorderSide(color: Colors.transparent),
);

const ButtonStyle buttonPrimary =  ButtonStyle(
  backgroundColor: MaterialStatePropertyAll(ThemeColor.grey225),
  padding: MaterialStatePropertyAll(
    EdgeInsets.symmetric(
      vertical: 15,
      horizontal: 20,
    ),
  ),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  ),
);