import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  String name;
  TextEditingController controller;
  String? Function(String?) validator;
  TextFormWidget(
      {Key? key,
      required this.name,
      required this.controller,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 7,
          controller: controller,
          validator: validator,
          style: const TextStyle(fontSize: 22),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red.shade500),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
