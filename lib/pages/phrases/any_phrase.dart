import 'package:flutter/material.dart';

class AnyPhrase extends StatelessWidget {
  String? _phrase;
  Color? _color;
  Color? _txtColor;


  AnyPhrase(this._phrase, this._color, this._txtColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 4.0),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      margin: const EdgeInsets.all(4.0),
      child: Text(
        _phrase!,
        style: TextStyle(color: _txtColor),
      ),
    );
  }
}
