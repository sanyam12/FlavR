import 'package:flavr/features/outlets_list_page/presentation/widgets/tab_button.dart';
import 'package:flutter/material.dart';

class ButtonRow extends StatefulWidget {
  final double width;
  final double height;
  final bool selectedTab;
  final void Function() onFirstPressed;
  final void Function() onSecondPressed;

  const ButtonRow({
    super.key,
    required this.width,
    required this.height,
    required this.selectedTab,
    required this.onFirstPressed,
    required this.onSecondPressed,
  });

  @override
  State<ButtonRow> createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.02125 * widget.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabButton(
            width: widget.width,
            onPressed: widget.onFirstPressed,
            text: "All Outlets",
            isSelected: widget.selectedTab,
          ),
          TabButton(
            width: widget.width,
            onPressed: widget.onSecondPressed,
            text: "Favorites",
            isSelected: !widget.selectedTab,
          )
        ],
      ),
    );
  }
}
