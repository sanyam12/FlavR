// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:developer';

import 'package:flavr/features/outlet_menu/data/data_provider/outlet_menu_api_provider.dart';
import 'package:flavr/features/outlet_menu/data/repository/outlet_menu_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flavr/features/outlet_menu/data/data_provider/outlet_menu_storage_provider.dart';
import 'package:flavr/main.dart';
import 'package:http/http.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test("getCurrentWeather returns weather data on success", () async {
    // final provider = OutletMenuApiProvider();
    // const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbnlhbXJhdHJlamExOEBnbWFpbC5jb20iLCJ1c2VyaWQiOiI2NThlZjczNDBlNjFjNGM4ZjdhODYzN2EiLCJ1c2VybmFtZSI6InNhbnlhbSByYXRyZWphIiwiaWF0IjoxNzA0MDExMjkzLCJleHAiOjE3MDY2MDMyOTN9.jX9CbfTRCeF0D3l8pn7e5qod88Qvk1eYmCITHxWrzrs";
    // final client = Client();
    // String data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
    // data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
    // data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
    // data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
    // data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
    // data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
    // data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
    // data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
    // data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
    // data = await provider.getOutletWithClient("646a5a0a51c3c24655b854e9", token, client);
    // log(data);
  });
}
