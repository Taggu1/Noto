import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

const kBlackColor = Color.fromRGBO(37, 37, 37, 1);

const kGreyColor = Color.fromRGBO(59, 59, 59, 1);

const klighGreyColor = Color.fromRGBO(47, 47, 47, 1);

final dateTextStyle = GoogleFonts.roboto(
  fontSize: 15,
);

const titleTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 30,
  height: 2,
);

final bodyTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w300,
  fontSize: 17,
  height: 1.8,
);

final buttonTextStyle =
    bodyTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.normal);
