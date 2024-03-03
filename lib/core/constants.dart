import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';

const API_DOMAIN = "https://flavr.tech/";
const CFEnvironment cfEnvironment = CFEnvironment.SANDBOX;
final theme = CFThemeBuilder()
    .setNavigationBarBackgroundColorColor("#FF0000")
    .setPrimaryFont("Menlo")
    .setSecondaryFont("Futura")
    .build();