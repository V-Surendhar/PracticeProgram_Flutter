import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'dart:io';

Future<bool?> showAlertDialog(
    BuildContext context, {
      required String title,
      required String content,
      required String defaultActionText,
      String? cancelActionText,
    }) {
  if (!Platform.isIOS) {
    return showDialog(

        context: context,
        builder: (context) => AlertDialog(

          title: Text(title),
          content: Text(content),
          actions: [

            if (cancelActionText != null)
              TextButton(
                child: Text(cancelActionText),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(defaultActionText)),
          ],
        ));
  }
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
