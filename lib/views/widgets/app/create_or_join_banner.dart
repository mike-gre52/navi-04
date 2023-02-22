import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/utils/colors.dart';

class CreateOrJoinBanner extends StatelessWidget {
  final Color color;
  const CreateOrJoinBanner({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      child: Column(
        children: [
          Icon(
            Icons.groups_rounded,
            size: 100,
            color: color,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Create or join a group to create your first list",
              style: TextStyle(
                  fontSize: 20, height: 1.2, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
