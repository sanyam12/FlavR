import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var cfPaymentGatewayService = CFPaymentGatewayService();
  final orderIDController = TextEditingController();
  final sessionIDController = TextEditingController();
  String test = "test";
  static const platform = MethodChannel('com.example.flavr/payment');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async{
    String batteryLevel;
    try{

      final result = await platform.invokeMethod('phonepe');
      batteryLevel = 'Battery level at $result % .';
    }on PlatformException catch(e){
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    super.initState();
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  void verifyPayment(String orderId) {
    log("Verify Payment");
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    log("Error while making payment ${errorResponse.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(test),
          TextField(
            controller: orderIDController,
            decoration: const InputDecoration(
              hintText: "Order ID"
            ),
          ),
          TextField(
            controller: sessionIDController,
            decoration: const InputDecoration(
              hintText: "Session ID"
            ),
          ),
          ElevatedButton(
            onPressed: () {
              try {
                var session = CFSessionBuilder()
                    .setEnvironment(CFEnvironment.SANDBOX)
                    .setOrderId(orderIDController.text)
                    .setPaymentSessionId(sessionIDController.text)
                    .build();

                var theme = CFThemeBuilder().setNavigationBarBackgroundColorColor("#FF0000").setPrimaryFont("Menlo").setSecondaryFont("Futura").build();
                var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
                    .setSession(session)
                    .setTheme(theme).build();

                cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
              } on CFException catch (e) {
                log("button ${e.message}");
              }
            },
            child: const Text(
              "Payment",
            ),
          ),

          Text(_batteryLevel),

          ElevatedButton(
              onPressed: (){
                _getBatteryLevel();
              },
              child: const Text("Platform")
          ),
        ],
      ),
    );
  }
}
