import 'package:flutter/material.dart';

class UserChatTile extends StatelessWidget {
  const UserChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 200,
        maxWidth: MediaQuery.sizeOf(context).height * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'getReferencegetReferencegetReference',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class FriendChatTile extends StatelessWidget {
  const FriendChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 200,
        maxWidth: MediaQuery.sizeOf(context).height * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withAlpha(55),
      ),
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'getReferencegetReferencegetReference',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
