import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class PriceSegmentedControll extends StatefulWidget {
  Function setPriceStatus;
  PriceSegmentedControll({
    Key? key,
    required this.setPriceStatus,
  }) : super(key: key);

  @override
  State<PriceSegmentedControll> createState() => _PriceSegmentedControllState();
}

class _PriceSegmentedControllState extends State<PriceSegmentedControll> {
  Object _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      children: <int, Widget>{
        0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$',
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
              '\$\$',
              style: TextStyle(
                color: _selectedSegment == 1 ? CupertinoColors.white : black,
              ),
            ),
          ),
        ),
        2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '\$\$\$',
              style: TextStyle(
                color: _selectedSegment == 2 ? CupertinoColors.white : black,
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
            widget.setPriceStatus(value);
          });
        }
      },
    );
  }
}
