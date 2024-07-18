import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final Widget? rightWidget;
  final Function()? onpressed;
  final List<Color>? clrs;
  final BoxBorder? border;
  final Color? textClr;
  final double? fontSize;
  final double? letterSpacing;

  GradientButton(
      {required this.title,
      this.rightWidget,
      this.onpressed,
      this.clrs,
      this.border,
      this.textClr,
      this.fontSize,
      this.letterSpacing});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
      child: Ink(
        //width: 283,
        height: width < 1024 ? 54 : 90,
        decoration: BoxDecoration(
          border: border != null
              ? Border.all(color: Colors.blueAccent, width: 2)
              : null,
          gradient: LinearGradient(colors: clrs!),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 20),
          constraints: const BoxConstraints(
              minWidth: 88.0,
              minHeight: 60.0), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: rightWidget != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: TextStyle(
                    fontFamily: "poppins",
                    color: textClr != null ? textClr : Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: fontSize ?? 14,
                    letterSpacing: letterSpacing ?? 1),
              ),
              SizedBox(
                width: 15,
              ),
              rightWidget ?? Container()
            ],
          ),
        ),
      ),
      onPressed: onpressed,
    );
  }
}
