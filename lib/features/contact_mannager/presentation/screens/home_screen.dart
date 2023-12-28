import 'package:contactsbuddy/config/routes/route_const.dart';
import 'package:contactsbuddy/config/theme/app_themes.dart';
import 'package:contactsbuddy/core/utils/navigation_handler.dart';
import 'package:contactsbuddy/features/contact_mannager/presentation/bloc/bloc/contact_Manager/contact_manager_cubit.dart';
import 'package:contactsbuddy/features/contact_mannager/presentation/screens/edit_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ContactManagerCubit contactManagerCubit =
        BlocProvider.of<ContactManagerCubit>(context);
    ScrollController scrollController = ScrollController();
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 70,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CircleAvatar(
              radius: 38.0,
              backgroundColor: kAppBgMediumShade,
              child: ClipOval(
                child: SvgPicture.asset(
                  'assets/icons/avatar-default.svg',
                  height: 50,
                ),
              ),
            ),
          ),
          onTap: () {},
        ),
        backgroundColor: kAppBgColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: IconButton(
                onPressed: () {
                  NavigationHandler.navigate(
                      context, RouteConst.addContactScreen);
                },
                icon: Icon(
                  Icons.add_circle_rounded,
                  size: 40,
                  color: kPrimaryColor,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<ContactManagerCubit, ContactManagerState>(
                  builder: (context, state) {
                    return FutureBuilder(
                        future: contactManagerCubit.loadConatcts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              shrinkWrap: true,
                              controller: scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          1, // number of items in each row
                                      mainAxisSpacing:
                                          16.0, // spacing between rows
                                      crossAxisSpacing: 16.0,
                                      childAspectRatio: 4.5
                                      // spacing between columns
                                      ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditContactScreen(
                                                    contactEntity: snapshot
                                                        .data![index])));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: kAppBgLightestShade,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 24.0,
                                            backgroundColor: kAppBgMediumShade,
                                            child: ClipOval(
                                              child: SvgPicture.asset(
                                                'assets/icons/avatar-default.svg',
                                                height: 50,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}",
                                                    style: kContactTextStyle,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${snapshot.data![index].mobile}",
                                                    style: kGreyBodytextStyle,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return SizedBox(
                              height: size.height - 250,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              )),
                            );
                          }
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
