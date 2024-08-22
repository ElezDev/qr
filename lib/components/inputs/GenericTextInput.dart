import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GenericTextInput extends StatefulWidget {

  final String label;
  final bool validation;
  final String textValidation;
  final String borderColor;
  final double borderWidth;
  final String borderSideColor;
  final double borderSideWidth;
  final String helperColor;
  final String labelColor;
  final double labelFontSize;
  final TextInputType textInputType;
  final String colorStyle;
  final String cursorColor;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputFormatter inputFormatter;

  //Constructor
  const GenericTextInput(
      {super.key, required this.label,
      required this.validation,
      required this.textValidation,
      required this.borderColor,
      required this.borderWidth,
      required this.borderSideColor,
      required this.borderSideWidth,
      required this.helperColor,
      required this.labelColor,
      required this.labelFontSize,
      required this.textInputType,
      required this.colorStyle,
      required this.cursorColor,
      required this.controller,
      required this.obscureText,
      required this.inputFormatter});

  @override
  _GenericTextInputState createState() => _GenericTextInputState();
}

class _GenericTextInputState extends State<GenericTextInput> {
  @override
  Widget build(BuildContext context) => Container(
          child: TextFormField(
        maxLines:  1,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText,
        readOnly:  false,
        inputFormatters: <TextInputFormatter>[widget.inputFormatter],
        cursorColor: Color(int.parse(widget.cursorColor)),
        style: TextStyle(color: Color(int.parse(widget.colorStyle))),
        decoration: inputDecoration(
            label: widget.label,
            validation: widget.validation,
            textValidation: widget.textValidation,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            borderSideColor: widget.borderSideColor,
            borderSideWidth: widget.borderSideWidth,
            helperColor: widget.helperColor,
            labelColor: widget.labelColor,
            labelFontSize: widget.labelFontSize),
      ));

  InputDecoration inputDecoration({
    required String label,
    required bool validation,
    required String textValidation,
    required String borderColor,
    required double borderWidth,
    required String borderSideColor,
    required double borderSideWidth,
    required String helperColor,
    required String labelColor,
    required double labelFontSize,
  }) =>
      InputDecoration(
          labelText: label,
          hintText:  '',
          helperText: validation ? textValidation : '',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color(int.parse(borderColor)), width: borderWidth)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color(int.parse(borderSideColor)),
                width: borderSideWidth),
          ),
          helperStyle: TextStyle(color: Color(int.parse(helperColor))),
          hintStyle: TextStyle(
              color: Color(int.parse(helperColor)), fontSize: labelFontSize),
          labelStyle: TextStyle(
              color: Color(int.parse(labelColor)), fontSize: labelFontSize));
}
