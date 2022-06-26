import 'package:flutter/material.dart';

class SelectableTextButton extends StatefulWidget {
  final Widget child;

  SelectableTextButton({required this.child});

  @override
  State<StatefulWidget> createState() => _SelectableTextButtonState();

}

class _SelectableTextButtonState extends State<SelectableTextButton> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child:  GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 28),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey
            ),
            borderRadius: BorderRadius.circular(5)
          ),
          child: widget.child,
        ),
      ),
    );
  }

}