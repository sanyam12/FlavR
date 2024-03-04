import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';

const API_DOMAIN = "https://flavr.tech/";
const CFEnvironment cfEnvironment = CFEnvironment.SANDBOX;
final theme = CFThemeBuilder()
    .setNavigationBarBackgroundColorColor("#FF0000")
    .setPrimaryFont("Menlo")
    .setSecondaryFont("Futura")
    .build();

const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);