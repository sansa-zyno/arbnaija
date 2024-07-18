import 'package:flutter/material.dart';
import 'package:surebetcalc/constants/app_colors.dart';

class CurvedTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? type;
  final bool? obscureText;
  final int? maxlines;
  final String? Function(String?)? validator;
  //final void Function(String)? onChange;
  final Widget? suffixIcon;
  final bool? readOnly;
  final FocusNode? focusNode;

  CurvedTextField(
      {this.controller,
      this.hint,
      this.obscureText,
      this.type,
      this.maxlines,
      this.validator,
      //this.onChange,
      this.suffixIcon,
      this.readOnly,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextFormField(
      readOnly: readOnly ?? false,
      focusNode: focusNode,
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      obscureText: obscureText ?? false,
      maxLines: maxlines,
      cursorColor: appColor,
      decoration: InputDecoration(
          prefix: SizedBox(width: 10),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColor, width: 2.0),
              borderRadius: BorderRadius.circular(8)),
          contentPadding:
              EdgeInsets.symmetric(vertical: width < 1024 ? 15 : 30),
          alignLabelWithHint: false,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hint ?? '',
          hintStyle: TextStyle(color: Colors.black45),
          suffixIcon: suffixIcon ?? null),
      //onChanged: onChange,
      validator: validator,
    );
  }
}
