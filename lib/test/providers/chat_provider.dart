import 'package:flutter/material.dart';
import 'package:sarti_mobile/test/config/helpers/get_yes_no_answer.dart';
import 'package:sarti_mobile/test/domain/entities/msg.dart';

class ChatProvider extends ChangeNotifier {

  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();
  List<Msg> messagesList = [
    Msg(text: 'Hola amor', fromWho: FromWho.hers),
    Msg(text: 'Hola', fromWho: FromWho.mine),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMsg = Msg(text: text, fromWho: FromWho.mine);
    messagesList.add(newMsg);

    if (text.endsWith('?')) {
      await receiveMessage();
    }

    notifyListeners();
    scrollToBottom();
  }

  Future<void> receiveMessage() async{
    final herMsg = await getYesNoAnswer.getAnswer();
    messagesList.add(herMsg);
    notifyListeners();
    scrollToBottom();
  }

  Future<void> scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}