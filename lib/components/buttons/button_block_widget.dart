import 'package:flutter/material.dart';

class ButtonBlockWidget extends StatelessWidget {
  const ButtonBlockWidget(
      {Key key,
      @required this.color,
      @required this.text,
      @required this.border,
      @required this.onPressed})
      : super(key: key);

  final Color color;
  final Text text;
  final Color border;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: TextButton(
        onPressed: this.onPressed,
        style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all(Size(double.infinity, 44)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.green[900])
        ),
        child: this.text,
      ),
    );
  }
}
