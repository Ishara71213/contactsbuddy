import 'package:contactsbuddy/config/routes/route_const.dart';
import 'package:contactsbuddy/config/theme/app_themes.dart';
import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/core/components/input_field_with_lable.dart';
import 'package:contactsbuddy/core/components/mobile_input_field_with_lable.dart';
import 'package:contactsbuddy/core/enum/states.dart';
import 'package:contactsbuddy/core/utils/navigation_handler.dart';
import 'package:contactsbuddy/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileNoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
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
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: kAppBgColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(32))),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                      key: formKeySignUp,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: InputFieldWithLable(
                              labelName: "First Name",
                              controller: _firstNameController,
                              hintText: "First Name",
                              labelTextStyle: kInputFieldLabelLighterText,
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: InputFieldWithLable(
                              labelName: "Last Name",
                              controller: _lastNameController,
                              hintText: "Last Name",
                              labelTextStyle: kInputFieldLabelLighterText,
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: InputFieldWithLable(
                              labelName: "Email",
                              controller: _emailController,
                              hintText: "Email",
                              labelTextStyle: kInputFieldLabelLighterText,
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                            ),
                          ),
                          MobileInputFieldWithLable(
                            labelName: "Mobile Number",
                            controller: _mobileNoController,
                            hintText: "Mobile Number",
                            labelTextStyle: kInputFieldLabelLighterText,
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: InputFieldWithLable(
                              labelName: "Password",
                              controller: _passwordController,
                              hintText: "Enter strong password",
                              labelTextStyle: kInputFieldLabelLighterText,
                              obscureText: true,
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: InputFieldWithLable(
                              labelName: "Confirm Password",
                              controller: _confirmPasswordController,
                              hintText: "Re enter your password",
                              labelTextStyle: kInputFieldLabelLighterText,
                              obscureText: true,
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
                                      initText: 'Sign Up',
                                      loadingText: 'Signing Up',
                                      successText: 'Done',
                                      onPressed: () {
                                        if (formKeySignUp.currentState!
                                            .validate()) {
                                          submitSignUp(context);
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
                                padding:
                                    const EdgeInsets.only(top: 10.0, bottom: 2),
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
                                                  RouteConst.signInScreen);
                                        },
                                        child: Text(
                                          "Sign In",
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
            ),
          ),
        ),
      ),
    );
  }

  void submitSignUp(context) async {
    await BlocProvider.of<UserCubit>(context).submitSignUp(
        user: UserEntity(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            mobile: _mobileNoController.text,
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text));
  }
}
