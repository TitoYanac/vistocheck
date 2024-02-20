import 'package:flutter/material.dart';

class AppLogoLogin extends StatefulWidget {
  const AppLogoLogin({super.key});

  @override
  State<AppLogoLogin> createState() => _AppLogoLoginState();
}

class _AppLogoLoginState extends State<AppLogoLogin> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).orientation == Orientation.portrait ? 50 : 0,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).orientation == Orientation.portrait ? 150 : 400,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.06),
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Colors.transparent,

            ),
            child:  FittedBox(fit: BoxFit.contain,child: Image.asset("assets/icons/icon_logo.png")),

          ),
        ],
      ),
    );
  }
}
