import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/messages/scaffold_messages.dart';
import '../../../events/widgets/pages/event_page.dart';
import '../../bloc/login_bloc.dart';
import '../atoms/app_logo_login.dart';
import '../atoms/bg_login.dart';
import '../atoms/input_password.dart';
import '../atoms/input_username.dart';
import '../atoms/login_button.dart';

class LoginTemplate extends StatefulWidget {
  const LoginTemplate({super.key});

  @override
  State<LoginTemplate> createState() => _LoginTemplateState();
}

class _LoginTemplateState extends State<LoginTemplate> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        if (state is LoginError) {
          showErrorMessage(context, "Error al iniciar sesión");
        } else if (state is LoginSuccess) {
          showSuccessMessage(context, "Bienvenido!");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EventPage()));
        }
      },

        builder: (BuildContext context, state) {
        debugPrint("hola: ${state.userData?.fullName??""}");
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                const BgLogin(),
                const AppLogoLogin(),

                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 400,
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("VistoCheck",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        InputUsername(
                          controller: _userNameController,
                          prefix: true,
                        ),
                        InputPassword(
                          controller: _passwordController,
                          prefix: true,
                        ),
                        LoginButton(username: _userNameController, password: _passwordController, message: state.message),
                        if(state.userData?.role == "admin")
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context).signupUser(
                              _userNameController.text,
                              _passwordController.text,
                              _passwordController.text,
                            );
                          },
                          child: const Text("Registrate",
                              style: TextStyle(

                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationColor: Colors.white,
                              ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
