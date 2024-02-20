import 'package:flutter/material.dart';

class BgLogin extends StatefulWidget {
  const BgLogin({super.key});

  @override
  State<BgLogin> createState() => _BgLoginState();
}

class _BgLoginState extends State<BgLogin> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(
            "assets/images/bg_login.png",
          ),
        ),
      ),
    );
  }
}
