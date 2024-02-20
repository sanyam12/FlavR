import 'package:flavr/core/components/button_types.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final double width;
  final double height;
  final bool? disabled;
  final ButtonType type;
  final Icon? trailing;

  const ButtonComponent({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    this.disabled,
    required this.type,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: _getSize(),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: disabled??true ?onPressed:null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            if(trailing!=null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: trailing!,
              )
          ],
        )
      ),
    );
  }

  _getSize(){
    if(type == ButtonType.ShortButton){
      return const Size(200, 45);
    }else if(type == ButtonType.LongButton){
      return Size(0.7861111111*width, 45);
    }
  }
}
