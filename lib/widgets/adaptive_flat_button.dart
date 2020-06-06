import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final buttonText;
  final handleTap;

  AdaptiveRaisedButton({@required this.buttonText, @required this.handleTap});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            onPressed: handleTap,
            color: Theme.of(context).primaryColor,
            child: Text(
              buttonText,
            ),
          )
        : RaisedButton(
            onPressed: handleTap,
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
            child: Text(
              buttonText,
            ),
          );
  }
}
