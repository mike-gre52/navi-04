import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class PriceSegmentedControll extends StatefulWidget {
  Function setPriceStatus;
  int initialValue;
  PriceSegmentedControll({
    Key? key,
    required this.setPriceStatus,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<PriceSegmentedControll> createState() => _PriceSegmentedControllState();
}

class _PriceSegmentedControllState extends State<PriceSegmentedControll> {
  Object _selectedSegment = 2;
  @override
  void initState() {
    _selectedSegment = widget.initialValue - 1;
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
            '\$',
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
              '\$\$',
              style: TextStyle(
                color: _selectedSegment == 1 ? CupertinoColors.white : black,
              ),
            ),
          ),
        ),
        2: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
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
            print("setting segmented value");
            _selectedSegment = value;
            widget.setPriceStatus((value as int) + 1);
          });
        }
      },
    );
  }
}
