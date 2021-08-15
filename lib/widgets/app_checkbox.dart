import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  String text;
  Widget child;

  AppCheckbox(this.text, this.child);

  @override
  _AppCheckboxState createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool boxChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: boxChecked,
              onChanged: (newVal) {
                setState(() {
                  boxChecked = newVal!;
                });
              },
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(widget.text),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        Opacity(
          opacity: boxChecked ? 1.0 : 0.3,
          child: AbsorbPointer(absorbing: !boxChecked, child: widget.child),
        ),
      ],
    );
  }
}
