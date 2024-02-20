import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key, required this.username, required this.password, required this.message});
  final TextEditingController username;
  final TextEditingController password;
  final String message;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  String message = "";
  @override
  void initState() {
    message = widget.message;
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if (widget.message != message) {
      setState(() {
        message = widget.message;
      });
    }
    super.didChangeDependencies();
  }
  @override
  void didUpdateWidget(covariant LoginButton oldWidget) {
    if (widget.message != message) {
      setState(() {
        message = widget.message;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10,),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<LoginBloc>(context).fetchUser(
                widget.username.text,
                widget.password.text,
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(140, 9, 3, 1),
              ),
            ),
            child: Text(widget.message,
              style: const TextStyle(
                  color: Colors.white
              ),),
          ),
        ),
        const SizedBox(width: 10,),
      ],
    );
  }
}

