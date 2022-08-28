import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class DeliverySegmentedControll extends StatefulWidget {
  Function setDeliveryStatus;
  DeliverySegmentedControll({
    Key? key,
    required this.setDeliveryStatus,
  }) : super(key: key);

  @override
  State<DeliverySegmentedControll> createState() =>
      _DeliverySegmentedControllState();
}

class _DeliverySegmentedControllState extends State<DeliverySegmentedControll> {
  Object _selectedSegment = 1;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      children: <int, Widget>{
        0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Yes',
            style: TextStyle(
              color: _selectedSegment == 0 ? CupertinoColors.white : black,
            ),
          ),
        ),
        1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
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
