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
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) =>
                            RecentlyDeletedBottomPopup(list: list));
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
