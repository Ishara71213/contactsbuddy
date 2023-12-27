import 'package:contactsbuddy/config/routes/route_const.dart';
import 'package:contactsbuddy/config/theme/app_themes.dart';
import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/core/components/input_field_with_lable.dart';
import 'package:contactsbuddy/core/enum/states.dart';
import 'package:contactsbuddy/core/utils/navigation_handler.dart';
import 'package:contactsbuddy/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is UserSuccess) {
          await Future.delayed(const Duration(seconds: 1), () {
            BlocProvider.of<AuthCubit>(context).appStarted();
          });
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: size.height,
                          width: size.width,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          height: size.height - 425,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: SvgPicture.asset(
                                'assets/icons/logo-icon-with-name.svg',
                                height: 200,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kAppBgColor,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32))),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 34,
                      ),
                      Text(
                        "Sign up Details",
                        style: kBlackHeaddertextStyle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Lets connect with contacts buddy",
                        style: kGreyBodytextStyle,
                      ),
                      SizedBox(
                        height: 32.0,
                        child: BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            return (state is UserFailrue)
                                ? Column(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          BlocProvider.of<UserCubit>(context)
                                              .errorMsg,
                                          style: kwarningText,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ),
                      Form(
                        key: formKeySignIn,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: InputFieldWithLable(
                                labelName: "Email",
                                controller: _emailController,
                                hintText: "Email",
                                isMandotary: true,
                                labelTextStyle: kInputFieldLabelLighterText,
                                prefixIcon: const Icon(Icons.email_rounded),
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: InputFieldWithLable(
                                labelName: "Password",
                                controller: _passwordController,
                                hintText: "Password",
                                labelTextStyle: kInputFieldLabelLighterText,
                                prefixIcon: const Icon(Icons.lock),
                                obscureText: true,
                                isMandotary: true,
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                BlocBuilder<UserCubit, UserState>(
                                  builder: (context, state) {
                                    return FilledButtonWithLoader(
                                        initText: 'Sign In',
                                        loadingText: 'Signing In',
                                        successText: 'Done',
                                        onPressed: () {
                                          if (formKeySignIn.currentState!
                                              .validate()) {
                                            submitSignIn(context);
                                          }
                                        },
                                        state: (state is UserLoading)
                                            ? States.loading
                                            : (state is UserSuccess)
                                                ? States.success
                                                : States.initial);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Already have an account?",
                                          style: kBlackSmalltextStyle),
                                      const SizedBox(width: 4.0),
                                      TextButton(
                                          onPressed: () {
                                            NavigationHandler
                                                .navigateWithRemovePrevRoute(
                                                    context,
                                                    RouteConst.signUpScreen);
                                          },
                                          child: Text(
                                            "Sign Up",
                                            style: kPrimaryColorSmalltextStyle,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitSignIn(context) async {
    await BlocProvider.of<UserCubit>(context).submitSignIn(
        user: UserEntity(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }
}
