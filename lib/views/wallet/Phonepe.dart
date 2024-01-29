import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhonepePayment extends StatefulWidget {
  const PhonepePayment({Key? key,}): super(key: key);

  @override
  State<PhonepePayment> createState() => _PhonepePaymentState();
}

class _PhonepePaymentState extends State<PhonepePayment> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
        child: Scaffold(

        ),
    );
  }
  Future<bool> _onBackPressed() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Transaction?'),
        content: Text('Are you sure you want to cancel the transaction?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Confirm cancel
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Do not cancel
            },
            child: Text('No'),
          ),
        ],
      ),
    )) ?? false;
  }
}



