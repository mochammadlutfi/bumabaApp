import 'package:flutter/material.dart';

class KeyboardKeyWidget extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  KeyboardKeyWidget({
    @required this.label,
    @required this.value,
    @required this.onTap,
  });

  @override
  _KeyboardKeyWidgetState createState() => _KeyboardKeyWidgetState();
}

class _KeyboardKeyWidgetState extends State<KeyboardKeyWidget> {

  renderLabel(){
    if(widget.label is Widget){
      return widget.label;
    }

    return Text(
      widget.label,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.grey,
      onTap: (){
        widget.onTap(widget.value);
      },
      child: AspectRatio(
        aspectRatio: 2,
        child: Container(
          child: Center(
            child: renderLabel(),
          ),
        ),
      ),
    );
  }
}