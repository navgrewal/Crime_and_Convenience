import 'package:flutter/material.dart';

AppBar appBarWidget(){
  return AppBar(
      centerTitle: true,
      title: Text(
                "Crime & Convenience",
                style: TextStyle(
                    fontFamily: "Signatra",
                    color: Colors.white,
                    fontSize: 30
                    ),
              ),
    );
}