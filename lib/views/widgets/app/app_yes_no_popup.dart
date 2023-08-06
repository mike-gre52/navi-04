import 'package:flutter/cupertino.dart';

class AppYesNoPopup extends StatelessWidget {
  final String header;
  final String subHeader;
  final String leftActionButton;
  final String rightActionButton;
  final Function leftActionFunction;

  const AppYesNoPopup({
    super.key,
    required this.header,
    required this.subHeader,
    required this.leftActionButton,
    required this.rightActionButton,
    required this.leftActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(header),
      content: Text(subHeader),
      actions: [
        CupertinoDialogAction(
          child: Text(leftActionButton),
          onPressed: () {
            leftActionFunction();
          },
        ),
        CupertinoDialogAction(
          child: Text(rightActionButton),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
