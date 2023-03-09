import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/lists/recently_deleted_popup.dart';

import '../../widgets/app/app_header.dart';
import '../../widgets/lists/list_column.dart';

class RecentlyDeleted extends StatefulWidget {
  const RecentlyDeleted({Key? key}) : super(key: key);

  @override
  State<RecentlyDeleted> createState() => _RecentlyDeletedState();
}

class _RecentlyDeletedState extends State<RecentlyDeleted> {
  final list = Get.arguments as ListData;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height20 = screenHeight / 44.8;
    double height35 = screenHeight / 25.6;
    double width10 = screenWidth / 41.4;
    double fontSize20 = screenHeight / 44.8;

    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            headerText: 'Recently Deleted',
            headerColor: grey,
            borderColor: royalYellow,
            textColor: Colors.white,
            dividerColor: Colors.white,
            rightAction: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        //isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(height20),
                          ),
                        ),
                        builder: (context) =>
                            RecentlyDeletedBottomPopup(list: list));
                  },
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: height35,
                  ),
                ),
                SizedBox(width: width10),
                Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            onIconClick: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          ListColumn(
            list: list,
            isRecentlyDeleted: true,
          ),
        ],
      ),
    );
  }
}
