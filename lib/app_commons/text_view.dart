import 'package:flutter/material.dart';

enum TypeFace { normal, bold, interNormal, caveat }

class TextView extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  final TypeFace typeFace;
  final TextAlign textAlign;
  final int? maxLines;
  final bool handleOverflow;
  final bool underline;

  const TextView(
      {required this.text,
      this.color = Colors.black,
      this.size = 16,
      this.weight = FontWeight.w500,
      this.typeFace = TypeFace.normal,
      this.textAlign = TextAlign.start,
      this.underline = false,
      this.maxLines,
      this.handleOverflow = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: handleOverflow ? TextOverflow.ellipsis : null,
        style: TextStyle(
            fontFamily: getFontFamily(),
            fontSize: size,
            fontWeight: weight,
            color: color,
            decoration:
                underline ? TextDecoration.underline : TextDecoration.none,
            decorationColor: color));
  }

  String getFontFamily() {
    switch (typeFace) {
      case TypeFace.normal:
        return "Rosario_Reg";
      case TypeFace.bold:
        return "Rosario_Bold";
      case TypeFace.interNormal:
        return "Inter_Reg";
      case TypeFace.caveat:
        return "Caveat_Brush";
    }
  }
}
