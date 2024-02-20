import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';
import 'package:vistocheck/presentation/core/formatters/encrypto_pass.dart';
import '../../../../domain/entities/user_data.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late App app;
  late User user;
  late Realm realm;
  LoginBloc({required this.app, required this.user, required this.realm}) : super(LoginInitial(null)) {

    on<FetchUserEvent>((event, emit) async {
      emit(LoginLoading(null));

      try {
        String cryptedPassword = cryptoPass(event.password, getSalt(), iteraciones: 2);
        // Verificar si el usuario existe en la base de datos
        var users = realm.all<UserData>().where((u) => u.userName == event.username && u.password == cryptedPassword ).toList();
        if (users.isNotEmpty) {
          var userData = users.first;
          realm.write(() {
            userData.lastLogin = DateTime.now();
            userData.isOnline = true;
            realm.add(userData);
          });

          // Si el usuario existe, crear las credenciales y vincularlas al usuario
          final credentials = Credentials.emailPassword(event.username,cryptedPassword);
          user.linkCredentials(credentials);

          emit(LoginSuccess(userData));
          await Future.delayed(const Duration(seconds: 1));
          emit(LoginInitial(userData));
        } else {
          emit(LoginError(null, "Error al iniciar sesión"));
          await Future.delayed(const Duration(seconds: 2));
          emit(LoginInitial(null));
        }
      } catch (e) {
        emit(LoginError(null, "Error al iniciar sesión"));
        await Future.delayed(const Duration(seconds: 2));
        emit(LoginInitial(null));
      }
    });



    on<SignupUserEvent>((event, emit) async {
      emit(RegisterLoading(null));

      // Verificar si el usuario ya existe en la base de datos antes de registrar
      var existingUsers = realm.all<UserData>().where((u) => u.userName == event.username).toList();
      if (existingUsers.isNotEmpty) {
        emit(RegisterError(null, "Usuario ya existe"));
        await Future.delayed(const Duration(seconds: 2));
        emit(RegisterInitial(null));
        return;
      }

      // Realizar la validación de contraseña
      if (event.password.length < 6) {
        emit(RegisterError(null, "Error de contraseña"));
        await Future.delayed(const Duration(seconds: 2));
        emit(RegisterInitial(null));
        return;
      }

      try {
        // Registrar el usuario utilizando las credenciales proporcionadas
        final authProvider = EmailPasswordAuthProvider(app);
        String cryptedPassword = cryptoPass(event.password, getSalt(), iteraciones: 2);
        await authProvider.registerUser(event.username, cryptedPassword);

        // Crear el usuario en la base de datos
        var now = DateTime.now();

        ObjectId id = ObjectId();
        String userName = event.username;
        String password = cryptedPassword;
        String status = "activo";
        DateTime dateCreation = now;
        DateTime lastDateModified = now;
        bool isOnline = false;
        DateTime lastLogin = now;
        DateTime lastLogout = now;
          String? fullName;
        int? phone;
        int? age;
        String? email;
        bool? verifiedEmail;
        String? role = "employee";
        String? urlImg;
        var userData = UserData(
          id,
          userName,
          password,
          status,
          dateCreation,
          lastDateModified,
          isOnline,
          lastLogin,
          lastLogout,
          fullName: fullName,
          phone: phone,
          age: age,
          email: email,
          verifiedEmail: verifiedEmail,
          role: role,
          urlImg: urlImg,
        );
        realm.write(() {
          realm.add(userData);
        });

        emit(RegisterSuccess(null));
        await Future.delayed(const Duration(seconds: 1));
        emit(RegisterInitial(null));
      } catch (e) {
        emit(RegisterError(null, "Error al registrar usuario"));
        await Future.delayed(const Duration(seconds: 1));
        emit(RegisterInitial(null));
      }
    });


    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading(state.userData));
      try {
        final App app = App(AppConfiguration('events-dxmrb',
            defaultRequestTimeout: const Duration(seconds: 120)));
        await app.currentUser!.logOut();
        emit(LogoutSuccess(null));
      } catch (e) {
        emit(LogoutError(null, "Error al cerrar sesión"));
      } finally {
        await Future.delayed(const Duration(seconds: 1));
        emit(LogoutInitial(null));
      }
    });

  }

  void fetchUser(String username, String password) => add(FetchUserEvent(username: username, password: password));

  void signupUser(String username, String password, String confirmPassword) => add(SignupUserEvent(username: username, password: password, confirmPassword: confirmPassword));

  void logout(String username) => add(LogoutEvent(username: username));

}

class LoginEvent {
  final String username;
  LoginEvent({required this.username});
}

class FetchUserEvent extends LoginEvent {
  final String password;
  FetchUserEvent({required this.password, required super.username});
}

class SignupUserEvent extends LoginEvent {
  final String password;
  final String confirmPassword;
  SignupUserEvent({required this.password, required this.confirmPassword, required super.username});
}

class LogoutEvent extends LoginEvent {
  LogoutEvent({required super.username});
}

class LoginState {
  UserData? userData;
  String message = "";
  LoginState({required this.userData, required this.message});
}

class LoginInitial extends LoginState {
  LoginInitial(UserData? userData) : super(userData: userData, message: "Iniciar sesión");
}

class LoginLoading extends LoginState {
  LoginLoading(UserData? userData) : super(userData: userData, message: "Buscando usuario...");
}

class LoginSuccess extends LoginState {
  LoginSuccess(UserData? userData) : super(userData: userData, message: "Bienvenido");
}

class LoginError extends LoginState {
  LoginError(UserData? userData, String message) : super(userData: userData, message: message);
}

class RegisterInitial extends LoginState {
  RegisterInitial(UserData? userData) : super(userData: userData, message: "Iniciar sesión");
}

class RegisterLoading extends LoginState {
  RegisterLoading(UserData? userData) : super(userData: userData, message: "Registrando usuario...");
}

class RegisterSuccess extends LoginState {
  RegisterSuccess(UserData? userData) : super(userData: userData, message: "Registrado");
}

class RegisterError extends LoginState {
  RegisterError(UserData? userData, String message) : super(userData: userData, message: message);
}

class LogoutInitial extends LoginState {
  LogoutInitial(UserData? userData) : super(userData: userData, message: "Cerrar sesión");
}

class LogoutLoading extends LoginState {
  LogoutLoading(UserData? userData) : super(userData: userData, message: "Cerrando sesión...");
}

class LogoutSuccess extends LoginState {
  LogoutSuccess(UserData? userData) : super(userData: userData, message: "Adios");
}

class LogoutError extends LoginState {
  LogoutError(UserData? userData, String message) : super(userData: userData, message: message);
}



