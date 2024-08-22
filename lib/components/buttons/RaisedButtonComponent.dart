// ignore: file_names
import 'package:flutter/material.dart';

class RaisedButtonComponent extends StatefulWidget {
  final String text;
  final String textColor;
  final String color;
  final double elevation;
  final double borderRadius;
  final Function() onClick;

  const RaisedButtonComponent({super.key, 
    required this.text,
    required this.textColor,
    required this.color,
    required this.elevation,
    required this.borderRadius,
    required this.onClick,
  });
  @override
  _RaisedButtonComponentState createState() => _RaisedButtonComponentState();
}

class _RaisedButtonComponentState extends State<RaisedButtonComponent> {
  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(Color(int.parse(widget.color))),
          elevation: WidgetStateProperty.all(widget.elevation),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius)),
          )),
      onPressed: () => widget.onClick(),
      child: chidIcon(widget));

  Widget chidIcon(dynamic widget) {
    return Text(widget.text,
        style:
            TextStyle(fontSize: 14, color: Color(int.parse(widget.textColor))));
  }
}
