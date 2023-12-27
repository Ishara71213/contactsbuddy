import 'package:contactsbuddy/config/routes/route_const.dart';
import 'package:contactsbuddy/config/theme/app_themes.dart';
import 'package:contactsbuddy/core/utils/navigation_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashDataLoadScreen extends StatefulWidget {
  const SplashDataLoadScreen({super.key});

  @override
  State<SplashDataLoadScreen> createState() => _SplashDataLoadScreen();
}

class _SplashDataLoadScreen extends State<SplashDataLoadScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> loadData() async {
      Future.delayed(const Duration(seconds: 2), () {
        NavigationHandler.navigateWithRemovePrevRoute(
            context, RouteConst.homeScreen);
      });
    }

    loadData();
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: Center(
          child: Opacity(
            opacity: 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo-icon.svg',
                  height: 80,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
