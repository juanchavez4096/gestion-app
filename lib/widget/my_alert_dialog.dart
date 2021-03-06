import 'package:flutter/material.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class MyAlertDialog {

  static Future<ConfirmAction> confirmDialog(BuildContext context, String titulo, String contenido) async {
    return showDialog<ConfirmAction>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(contenido),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.grey,
              child: Text('Rechazar'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            ),
            FlatButton(
              textColor: Colors.red,
              child: Text('Aceptar'),
              onPressed: () => Navigator.of(context).pop(ConfirmAction.ACCEPT),
            ),
          ],
        );
      },
    );
  }

  static Future<void> alertDialog(BuildContext context, String titulo, String contentido) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(contentido),
          actions: <Widget>[
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

}