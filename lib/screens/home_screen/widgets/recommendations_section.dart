import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techogachat/models/chat_user.dart';
import 'package:techogachat/models/screen_arguements.dart';
import 'package:techogachat/screens/chat_screen/chat_screen.dart';
import 'package:techogachat/shared/shared_view_models/recommendations_view_model.dart';
import 'package:techogachat/utils/extensions.dart';

class RecommendationsSection extends StatelessWidget {
  final List<ChatUser> users;
  final bool loading;
  const RecommendationsSection({
    super.key,
    required this.loading,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Builder(builder: (context) {
        if (loading) {
          return const CircularProgressIndicator();
        }
        return ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: users
              .map(
                (e) => RecommendationCard(
                  user: e,
                ),
              )
              .toList(),
        );
      }),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final ChatUser user;
  const RecommendationCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecommendationsViewModel(user),
      child: Consumer<RecommendationsViewModel>(
        builder: (context, value, child) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => value.createChatRoom(
            (chatRoomId) => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatScreen(
                  screenArguements: ChatRoomScreenArguements(
                      friend: user, roomId: chatRoomId)),
            )),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(15),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withAlpha(55),
                ),
                child: user.avatar == null || user.avatar!.isEmpty
                    ? const Icon(Icons.person)
                    : Image.network(user.avatar!),
              ),
              10.vSpace,
              Text(
                '${user.name}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
