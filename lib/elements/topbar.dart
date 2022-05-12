import 'package:flutter/material.dart';

getTopBar(BuildContext context, {String? title}) {
  return PreferredSize(
    preferredSize: const Size(0, 200),
    child: Stack(
      children: [
        Container(
          color: Colors.transparent,
          child: Image.asset(
            'assets/img/header_bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 50.0, right: 10),
            child: Builder(
                builder: (context) => // Ensure Scaffold is in context
                    IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer()))),
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Center(
            child: Container(
              height: 100,
              color: Colors.transparent,
              child: title != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(title,
                          style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )
                  : Image.asset('assets/img/logo_white.png',
                      fit: BoxFit.contain),
            ),
          ),
        ),
      ],
    ),
  );
}
