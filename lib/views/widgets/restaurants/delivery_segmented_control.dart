import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class DeliverySegmentedControll extends StatefulWidget {
  Function setDeliveryStatus;
  int initialValue;
  DeliverySegmentedControll({
    Key? key,
    required this.setDeliveryStatus,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<DeliverySegmentedControll> createState() =>
      _DeliverySegmentedControllState();
}

class _DeliverySegmentedControllState extends State<DeliverySegmentedControll> {
  Object _selectedSegment = 1;

  @override
  void initState() {
    _selectedSegment = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height10 = screenHeight / 89.6;
    double width10 = screenWidth / 41.4;
    return CupertinoSlidingSegmentedControl(
      children: <int, Widget>{
        0: Padding(
          padding: EdgeInsets.symmetric(horizontal: width10),
          child: Text(
            'Yes',
            style: TextStyle(
              color: _selectedSegment == 0 ? CupertinoColors.white : black,
            ),
          ),
        ),
        1: Padding(
          padding: EdgeInsets.symmetric(horizontal: width10),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height10),
            child: Text(
              'No',
              style: TextStyle(
                color: _selectedSegment == 1 ? CupertinoColors.white : black,
              ),
            ),
          ),
        ),
      },
      groupValue: _selectedSegment,
      thumbColor: appRed,
      onValueChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedSegment = value;
            widget.setDeliveryStatus(value);
          });
        }
      },
    );
  }
}
