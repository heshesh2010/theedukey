import 'package:flutter/material.dart';

getTopWaveBar(BuildContext context){
  return PreferredSize(
        preferredSize: const Size(0, 250),
        child: SafeArea(
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              // Set Appbar wave height
              child: Stack(
                children:  <Widget>[
                //  const  DemoBody(),
                  Padding(
                    padding: const EdgeInsets.only(top:60.0),
                    child: Center(
                      child: Container(
                        height: 100,
                        color: Colors.transparent,
                        child:Image.asset('assets/img/logo_white.png', fit: BoxFit.contain),

                      ),
                    ),
                  ),
                ],
              ),
     )));
}




