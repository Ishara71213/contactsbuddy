import 'package:contactsbuddy/config/routes/on_generate_route.dart';
import 'package:contactsbuddy/config/routes/route_const.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:contactsbuddy/features/contact_mannager/presentation/bloc/bloc/contact_Manager/contact_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:contactsbuddy/core/utils/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ContactsBuddy());
}

class ContactsBuddy extends StatelessWidget {
  const ContactsBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<ContactManagerCubit>(
            create: (_) => di.sl<ContactManagerCubit>()),
      ],
      child: const MaterialApp(
        title: 'Contacts Buddy',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        initialRoute: RouteConst.splashScreen,
        onGenerateRoute: OnGenerateRoute.route,
        home: null,
      ),
    );
  }
}
