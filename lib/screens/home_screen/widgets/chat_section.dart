import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techogachat/app_services/app_services.dart';
import 'package:techogachat/app_services/view_model_services.dart';
import 'package:techogachat/models/chat_room.dart';
import 'package:techogachat/models/screen_arguements.dart';
import 'package:techogachat/screens/chat_screen/chat_screen.dart';
import 'package:techogachat/services/user_services.dart';
import 'package:techogachat/utils/extensions.dart';

class ChatSection extends StatelessWidget {
  const ChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = AppServices.locate<ViewModelServices>().auth.user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat_room')
              .where('participants', arrayContains: _user!.userId!)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Data'),
              );
            }

            List<ChatRoom> rooms = [];

            for (var element in snapshot.data!.docs) {
              rooms.add(ChatRoom.fromJson(element));
            }

            if (rooms.isEmpty) {
              return const Center(
                child: Text('No Chats'),
              );
            }
            return Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Chat'),
                    Icon(Icons.more_horiz),
                  ],
                ),
                20.vSpace,
                ...rooms.map(
                  (e) => ChatTile(
                    chatRoom: e,
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class ChatTile extends StatelessWidget {
  final ChatRoom chatRoom;
  const ChatTile({
    super.key,
    required this.chatRoom,
  });

  @override
  Widget build(BuildContext context) {
    final userId = AppServices.locate<ViewModelServices>().auth.user!.userId!;

    return FutureBuilder(
      future: UserServices.getUser(
          userId: chatRoom.participants.firstWhere(
        (element) => element != userId,
      )),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatScreen(
                  screenArguements: ChatRoomScreenArguements(
                      friend: snapshot.data!, roomId: chatRoom.roomId)),
            )),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: snapshot.data!.avatar != null ||
                            snapshot.data!.avatar!.isNotEmpty
                        ? Image.network(
                            snapshot.data!.avatar!,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(),
                  ),
                  20.hSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${snapshot.data?.name}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        5.vSpace,
                        Text(
                          chatRoom.lastMessage,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('02:11'),
                      10.vSpace,
                      Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.yellow),
                        child: const Center(
                          child: Text('1'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
