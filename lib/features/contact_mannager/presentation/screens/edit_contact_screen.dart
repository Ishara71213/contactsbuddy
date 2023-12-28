import 'package:contactsbuddy/config/theme/app_themes.dart';
import 'package:contactsbuddy/core/components/input_field_with_lable.dart';
import 'package:contactsbuddy/core/components/mobile_input_field_with_lable.dart';
import 'package:contactsbuddy/core/enum/states.dart';
import 'package:contactsbuddy/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/entities/contact_entity.dart';
import 'package:contactsbuddy/features/contact_mannager/presentation/bloc/bloc/contact_Manager/contact_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditContactScreen extends StatefulWidget {
  final ContactEntity contactEntity;
  const EditContactScreen({super.key, required this.contactEntity});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final GlobalKey<FormState> formKeyAddContact = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _firstNameController.text = widget.contactEntity.firstName ?? "";
    _lastNameController.text = widget.contactEntity.lastName ?? "";
    _mobileNoController.text = widget.contactEntity.mobile ?? "";
    _emailController.text = widget.contactEntity.email ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthController.dispose();
    _mobileNoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocListener<ContactManagerCubit, ContactManagerState>(
      listener: (context, state) async {
        if (state is ContactCrudOptSuccess) {
          Navigator.pop(context);
          // await Future.delayed(const Duration(seconds: 1), () {});
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Edit Contact",
              style: kBlackHeaddertextStyle,
              textAlign: TextAlign.center,
            ),
            toolbarHeight: 80,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: kDarkGreyShade,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: kAppBgColor,
          ),
          body: Container(
            width: size.width,
            height: size.height - 80,
            decoration: BoxDecoration(
              color: kAppBgColor,
              border: Border(
                top: BorderSide(width: 0.7, color: kAppBarBorder),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Contact Information",
                              style: kInputFieldText,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: kAppBarBorder),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              children: [
                                Form(
                                  key: formKeyAddContact,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: InputFieldWithLable(
                                          labelName: "First Name",
                                          controller: _firstNameController,
                                          hintText: "First Name",
                                          labelTextStyle:
                                              kInputFieldLabelDarkText,
                                          isMandotary: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: InputFieldWithLable(
                                          labelName: "Last Name",
                                          controller: _lastNameController,
                                          hintText: "Last Name",
                                          labelTextStyle:
                                              kInputFieldLabelDarkText,
                                          prefixIcon: const Icon(Icons.lock),
                                          isMandotary: true,
                                        ),
                                      ),
                                      MobileInputFieldWithLable(
                                        labelName: "Mobile Number",
                                        controller: _mobileNoController,
                                        hintText: "Mobile Number",
                                        labelTextStyle:
                                            kInputFieldLabelLighterText,
                                        padding: const EdgeInsets.only(
                                            left: 8, bottom: 8),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: InputFieldWithLable(
                                          labelName: "Email",
                                          controller: _emailController,
                                          hintText: "Email",
                                          isMandotary: true,
                                          labelTextStyle:
                                              kInputFieldLabelDarkText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await BlocProvider.of<ContactManagerCubit>(
                                        context)
                                    .deleteConatct(
                                        entity: widget.contactEntity);
                              },
                              child: Text(
                                "Delete Contact",
                                style: kWarningTextButtonText,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return FilledButtonWithLoader(
                    initText: 'Update',
                    loadingText: 'Updating',
                    successText: 'Done',
                    onPressed: () {
                      if (formKeyAddContact.currentState!.validate()) {
                        saveContact(context);
                      }
                    },
                    state: (state is ContactCrudOptInitiate)
                        ? States.loading
                        : (state is ContactCrudOptSuccess)
                            ? States.success
                            : States.initial);
              },
            ),
          ),
        ),
      ),
    );
  }

  void saveContact(context) async {
    await BlocProvider.of<ContactManagerCubit>(context).updateConatct(
        entity: ContactEntity(
            // id: widget.contactEntity.id,
            createdDate: widget.contactEntity.createdDate,
            createdUser: widget.contactEntity.createdUser,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            mobile: _mobileNoController.text));
  }
}
