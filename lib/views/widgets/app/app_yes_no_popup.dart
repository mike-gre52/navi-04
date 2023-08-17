import 'package:flutter/cupertino.dart';

class AppYesNoPopup extends StatelessWidget {
  final String header;
  final String subHeader;
  final String confirmAction;
  final String cancelAction;
  final Function confirmActionFunction;

  const AppYesNoPopup({
    super.key,
    required this.header,
    required this.subHeader,
    required this.confirmAction,
    required this.cancelAction,
    required this.confirmActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(header),
      content: Text(subHeader),
      actions: [
        CupertinoDialogAction(
          child: Text(cancelAction),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text(confirmAction),
          onPressed: () {
            confirmActionFunction();
          },
        ),
      ],
    );
  }
}
