import 'package:bumaba/Config/color.dart';
import 'package:flutter/material.dart';

class DetailField extends StatefulWidget {
  final String label; // receives the value
  final String value;
  final double fontsize;
  final bool border;

  DetailField({ Key key, this.label, this.value, this.fontsize, this.border }): super(key: key);

  @override
  _DetailFieldState createState() => _DetailFieldState();
}

class _DetailFieldState extends State<DetailField> {
  @override
    Widget build(BuildContext context) {
    return Container(
      child: Material(
        shadowColor: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.border == true ? bodylight : Colors.transparent,
                width: 1.0,
              ),
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 0,
            color: Colors.transparent,
            child: InkWell( 
              splashColor: Colors.white30,
              onTap: (){},
              child: Container(
                padding: EdgeInsets.symmetric(vertical : 10.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.label,
                      style: TextStyle(fontSize: widget.fontsize, color: greytext),
                    ),
                    Text(widget.value,
                      style: TextStyle(fontSize: widget.fontsize, fontWeight : FontWeight.w600, color: blacktext),
                    ),
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}

