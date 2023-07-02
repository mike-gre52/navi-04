import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/utils/colors.dart';

const double _kItemExtent = 32.0;

class RecipeCategoriesPicker extends StatefulWidget {
  Function onSelect;
  RecipeCategoriesPicker({
    super.key,
    required this.onSelect,
  });

  @override
  State<RecipeCategoriesPicker> createState() => _RecipeCategoriesPickerState();
}

class _RecipeCategoriesPickerState extends State<RecipeCategoriesPicker> {
  List<String> categoriesPickerList = List<String>.from(categories);

  int _selectedCategory = 0;

  @override
  void initState() {
    categoriesPickerList.insert(0, "select");
    super.initState();
  }

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double width30 = screenWidth / 13.8;
    return GestureDetector(
      onTap: () {
        _showDialog(
          CupertinoPicker(
            //magnification: 1.22,
            squeeze: 1.2,
            //useMagnifier: true,
            itemExtent: _kItemExtent,
            // This sets the initial item.
            scrollController: FixedExtentScrollController(
              initialItem: _selectedCategory,
            ),
            // This is called when selected item is changed.
            onSelectedItemChanged: (int selectedItem) {
              widget.onSelect(selectedItem);
              setState(() {
                _selectedCategory = selectedItem;
              });
            },
            children: List<Widget>.generate(
              categoriesPickerList.length,
              (int index) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: width30),
                    child: Text("${index + 1}) ${categoriesPickerList[index]}"),
                  ),
                );
              },
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Recipe Category: ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text(
            categoriesPickerList[_selectedCategory],
            style: TextStyle(
              fontSize: 22.0,
              color: appBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
