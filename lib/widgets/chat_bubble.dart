import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formattedDate(DateTime date) {
  String dayOfWeek = DateFormat('EEEE').format(date);
  String formattedTime = DateFormat('HH:mm').format(date);
  return '${dayOfWeek.substring(0, 3)} ,$formattedTime';
}

// ignore: must_be_immutable
class ChatBuble extends StatelessWidget {
  ChatBuble({
    required this.message,
    super.key,
  });

  MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 15),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Color.fromARGB(255, 65, 64, 64),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              formattedDate(message.date),
              style: const TextStyle(
                fontSize: 8,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatBubleForFriend extends StatelessWidget {
  MessageModel message;
  ChatBubleForFriend({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, top: 16, bottom: 16, right: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color.fromARGB(255, 130, 129, 129),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              formattedDate(message.date),
              style: const TextStyle(
                fontSize: 8,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
