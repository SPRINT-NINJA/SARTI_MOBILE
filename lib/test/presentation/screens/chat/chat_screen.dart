import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarti_mobile/main.dart';
import 'package:sarti_mobile/test/domain/entities/msg.dart';
import 'package:sarti_mobile/test/presentation/widgets/chat/her_msg_bubble.dart';
import 'package:sarti_mobile/test/presentation/widgets/chat/my_mssg_bubble.dart';
import 'package:sarti_mobile/test/presentation/widgets/shared/msg_field_box.dart';
import 'package:sarti_mobile/test/providers/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/R.9f909e47ddfdd7ab255971b2575dcfb8?rik=8JdK90F8aI9J7Q&riu=http%3a%2f%2fwritestylesonline.com%2fwp-content%2fuploads%2f2016%2f08%2fFollow-These-Steps-for-a-Flawless-Professional-Profile-Picture-1024x1024.jpg&ehk=at%2bW8ahmVDAWSjLun4vkjMUmmlvUD7psBtJ5Bf9jSfA%3d&risl=&pid=ImgRaw&r=0')),
        ),
        title: const Text('Chat'),
        centerTitle: false,
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messagesList.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messagesList[index];
                  return message.fromWho == FromWho.mine
                      ? MyMssgBubble(message: message)
                      : HerMsgBubble(message: message);
                },
              ),
            ),
            MsgFieldBox(
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
