import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techogachat/models/chat_message.dart';
import 'package:techogachat/models/screen_arguements.dart';
import 'package:techogachat/screens/chat_screen/widgets/chat_tile.dart';
import 'package:techogachat/shared/shared.dart';

class ChatScreen extends StatefulWidget {
  final ChatRoomScreenArguements screenArguements;
  const ChatScreen({
    super.key,
    required this.screenArguements,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: widget.screenArguements.friend.avatar != null ||
                  widget.screenArguements.friend.avatar!.isNotEmpty
              ? NetworkImage(widget.screenArguements.friend.avatar!)
              : null,
        ),
        title: Text('${widget.screenArguements.friend.name}'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: InputField(
          textEditingController: _controller,
          suffixWidget: const Icon(Icons.send),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chatroom')
            .doc(widget.screenArguements.roomId)
            .collection('messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Data Yet'),
            );
          } else {
            List<ChatMessage> messages = [];

            for (var element in snapshot.data!.docs) {
              messages.add(ChatMessage.fromJson(element));
            }

            if (messages.isEmpty) {
              return const Center(
                child: Text('No Message Yet'),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: messages
                    .map(
                      (e) => const UserChatTile(),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
