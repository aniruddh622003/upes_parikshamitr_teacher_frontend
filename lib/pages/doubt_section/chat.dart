import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class ChatScreen extends StatelessWidget {
  final String personName;
  final String designation;

  const ChatScreen(
      {Key? key, required this.personName, required this.designation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personName,
                  style: TextStyle(fontSize: fontMedium, color: Colors.white),
                ),
                Text(
                  designation,
                  style: TextStyle(fontSize: fontSmall, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: ChatBody(),
        ));
  }
}

class ChatBody extends StatefulWidget {
  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatBubble(
                message: messages[index],
              );
            },
          ),
        ),
        _buildMessageInputField(),
      ],
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      height: 45,
      padding: EdgeInsets.fromLTRB(8, 8, 8, 10),
      color: Colors.blue[50],
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Type to ask doubt',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: secondaryColor),
            onPressed: () {
              _sendMessage();
            },
          ),
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

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: message.sender == 'user'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: message.sender == 'user' ? Colors.grey : primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message.text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
