import 'package:contactsbuddy/config/routes/route_const.dart';
import 'package:contactsbuddy/core/common/screens/splash_screen.dart';
import 'package:contactsbuddy/core/common/screens/splash_screen_data_loader.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:contactsbuddy/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:contactsbuddy/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:contactsbuddy/features/contact_mannager/presentation/screens/add_contact_screen.dart';
import 'package:contactsbuddy/features/contact_mannager/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    //final args = settings.arguments;
    String routeName = settings.name.toString();
    switch (settings.name) {
      case RouteConst.initialRoute:
        return materialBuilderAuthScreens(
            widget: const SignInScreen(), route: routeName);
      case RouteConst.splashScreen:
        return materialBuilder(widget: const SplashScreen(), route: routeName);
      case RouteConst.splashDataLoadScreen:
        return materialBuilder(
            widget: const SplashDataLoadScreen(), route: routeName);
      case RouteConst.signInScreen:
        return materialBuilderAuthScreens(
            widget: const SignInScreen(), route: routeName);
      case RouteConst.signUpScreen:
        return materialBuilderAuthScreens(
            widget: const SignUpScreen(), route: routeName);
      case RouteConst.homeScreen:
        return materialBuilder(widget: const HomeScreen(), route: routeName);
      case RouteConst.addContactScreen:
        return materialBuilder(
            widget: const AddContactScreen(), route: routeName);
      //error page
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}

//Use For Auth Screen route generate
//return the argument widget if Unauthenticated
MaterialPageRoute materialBuilderAuthScreens(
    {required Widget widget, required String route}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: route),
      builder: (context) => BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return const SplashDataLoadScreen();
              } else if (state is UnAuthenticated) {
                return widget;
              } else {
                return const SignInScreen();
              }
            },
          ));
}

//return the requested widget if user is authenticated
MaterialPageRoute materialBuilder(
    {required Widget widget, required String route}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: route),
      builder: (context) => BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return widget;
              } else {
                return const SignInScreen();
              }
            },
          ));
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
    );
  }
}
