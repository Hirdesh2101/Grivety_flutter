import 'dart:ui';
import './constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text,branch;
  final String img;

  const CustomDialogBox({ this.title, this.descriptions, this.text, this.img,this.branch}) ;

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    String s;
    String temp =widget.branch;
    widget.branch==''?s='':s='$temp Engineering';
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(color: Colors.black,offset: Offset(0,10),
              blurRadius: 10
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(color:Colors.black,fontSize: 22,fontWeight: FontWeight.w600),),
              Text(s,style: TextStyle(color:Colors.black,fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(color:Colors.black,fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(widget.text,style: TextStyle(color:Colors.black,fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: CircleAvatar(
                radius: 45,
                  backgroundImage: (widget.img == 'Male' || widget.img == 'Female')
                      ? widget.img == 'Male'
                          ? AssetImage("assests/male.jpg")
                          : AssetImage("assests/female.jpg")
                      : NetworkImage(widget.img)
              ),
            ),
        ),
      ],
    );
  }
}