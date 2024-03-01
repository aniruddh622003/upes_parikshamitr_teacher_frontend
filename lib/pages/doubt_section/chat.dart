import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class ChatScreen extends StatelessWidget {
  final String personName;
  final String designation;

  const ChatScreen(
      {super.key, required this.personName, required this.designation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
          ),
          shadowColor: black,
          elevation: 2,
          toolbarHeight: 75,
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personName,
                  textScaler: const TextScaler.linear(1),
                  style: const TextStyle(
                    fontSize: fontMedium,
                    color: Colors.white,
                  ),
                ),
                Text(
                  designation,
                  textScaler: const TextScaler.linear(1),
                  style:
                      const TextStyle(fontSize: fontSmall, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: const ChatBody(),
        ));
  }
}

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  ChatBodyState createState() => ChatBodyState();
}

class ChatBodyState extends State<ChatBody> {
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: messages[index],
                );
              },
            ),
          ),
        ),
        _buildMessageInputField(),
      ],
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      color: Colors.blue[50],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(right: 8),
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Type to ask doubt',
                contentPadding: EdgeInsets.all(8),
                border: InputBorder.none,
              ),
            ),
          )),
          Padding(
              padding: const EdgeInsets.only(top: 4),
              child: IconButton(
                icon: const Icon(Icons.send, color: secondaryColor),
                onPressed: () {
                  _sendMessage();
                },
              ))
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(sender: 'user', text: messageText));
        // Simulate a response from the other person (for demonstration purposes)
        messages.add(ChatMessage(
            sender: 'person',
            text: 'Okay, sending someone to take care of this.'));
      });

      // Clear the text field after sending the message
      messageController.clear();
    }
  }
}

class ChatMessage {
  final String sender;
  final String text;

  ChatMessage({required this.sender, required this.text});
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: message.sender == 'user'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: message.sender == 'user' ? chatBubbleGrey : primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message.text,
            textScaler: const TextScaler.linear(1),
            style: TextStyle(
                color: message.sender != 'user' ? Colors.white : black,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
