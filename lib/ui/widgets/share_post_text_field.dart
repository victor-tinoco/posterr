import 'package:flutter/material.dart';
import 'package:posterr/domain/domain.dart';

class SharePostTextField extends StatefulWidget {
  const SharePostTextField({Key? key, required this.onPost}) : super(key: key);

  final ValueChanged<String> onPost;

  @override
  State<SharePostTextField> createState() => _SharePostTextFieldState();
}

class _SharePostTextFieldState extends State<SharePostTextField> {
  final sharePostTextController = TextEditingController();

  @override
  void dispose() {
    sharePostTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: sharePostTextController,
            maxLength: maxPostMessageLength,
          ),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            widget.onPost(sharePostTextController.text);
            sharePostTextController.clear();
          },
        ),
      ],
    );
  }
}
