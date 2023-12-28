import 'package:contactsbuddy/config/routes/route_const.dart';
import 'package:contactsbuddy/config/theme/app_themes.dart';
import 'package:contactsbuddy/core/utils/navigation_handler.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:contactsbuddy/features/contact_mannager/presentation/bloc/bloc/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBar extends StatefulWidget {
  final String appBarTitle;

  const AppBar({super.key, this.appBarTitle = ""});

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    return Stack(
      children: [
        widget.appBarTitle != ""
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, top: 21, right: 12, left: 10),
                    child: Text(
                      widget.appBarTitle,
                      style: kBlackHeaddertextStyle,
                    ),
                  )
                ],
              )
            : const SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  // navigationHandler(context, RouteConst.settingsScreen);
                },
                icon: Icon(
                  Icons.menu_rounded,
                  size: 40,
                  color: kPrimaryColor,
                )),
            GestureDetector(onTap: () {
              NavigationHandler.navigate(context, RouteConst.profileScreen);
            }, child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: userCubit.userData != null &&
                          userCubit.userData!.imagePath != null &&
                          userCubit.userData!.imagePath != "null"
                      ? CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundColor: kGreyLightShade,
                          //foregroundImage: Image.memory(bytes),
                          child: Icon(
                            Icons.person,
                            color: kGreyColor,
                            size: 35,
                          ),
                        )
                      : CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundColor: kGreyLightShade,
                          child: Icon(
                            Icons.person,
                            color: kGreyColor,
                            size: 35,
                          ),
                        ),
                );
              },
            ))
          ],
        )
      ],
    );
  }
}
