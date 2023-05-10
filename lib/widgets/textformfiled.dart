import 'package:flutter/material.dart';


class TextFieldExample extends StatelessWidget {

  final String hintText;
  final String validator;
  Icon icon;
  final TextEditingController controller;

    TextFieldExample({required this.hintText, required this.controller,required this.validator,required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validator;
          }
          return null;
        },
        keyboardType: TextInputType.text,
        enabled: true,
        cursorColor: Colors.black,
        cursorHeight: 25,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blueGrey.shade50,
          hintText: hintText,
          prefixIcon: icon,
          focusColor: Colors.deepOrange,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xFFF89B76)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}