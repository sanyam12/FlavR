 import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flavr/core/CartChangeProvider.dart';
import 'package:flavr/core/data_provider/core_api_provider.dart';
import 'package:flavr/core/data_provider/core_storage_provider.dart';
import 'package:flavr/core/repository/core_cart_repository.dart';
import 'package:flavr/features/cart/data/data_providers/cart_api_provider.dart';
import 'package:flavr/features/cart/data/repository/cart_repository.dart';
import 'package:flavr/features/orders_list/bloc/orders_list_bloc.dart';
import 'package:flavr/features/orders_list/presentation/screens/orders_list.dart';
import 'package:flavr/features/outlet_menu/bloc/outlet_menu_bloc.dart';
import 'package:flavr/features/outlet_menu/data/data_provider/outlet_menu_api_provider.dart';
import 'package:flavr/features/outlet_menu/data/data_provider/outlet_menu_storage_provider.dart';
import 'package:flavr/features/outlet_menu/data/repository/outlet_menu_repository.dart';
import 'package:flavr/features/cart/bloc/cart_bloc.dart';
import 'package:flavr/pages/edit_profile/EditProfile.dart';
import 'package:flavr/pages/home_page/HomePage.dart';
import 'package:flavr/pages/payment/payment.dart';
import 'package:flavr/pages/profile_page/ProfiePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'features/google_sign_in/bloc/sign_in_with_google_bloc.dart';
import 'features/google_sign_in/presentation/screens/sign_in_with_google.dart';
import 'features/login_page/bloc/login_bloc.dart';
import 'features/login_page/data/data_provider/login_api_provider.dart';
import 'features/login_page/data/data_provider/login_secure_storage_provider.dart';
import 'features/login_page/data/repository/login_repository.dart';
import 'features/login_page/presentation/screens/login_page.dart';
import 'features/otp_screen/bloc/otp_screen_bloc.dart';
import 'features/otp_screen/data/data_provider/otp_api_provider.dart';
import 'features/otp_screen/data/repository/otp_repository.dart';
import 'features/outlet_menu/presentation/screens/outlet_menu.dart';
import 'features/outlets_list_page/bloc/outlet_list_bloc.dart';
import 'features/outlets_list_page/data/data_provider/outlet_list_api_provider.dart';
import 'features/outlets_list_page/data/data_provider/outlet_list_storage_provider.dart';
import 'features/outlets_list_page/data/repository/outlet_list_repository.dart';
import 'features/outlets_list_page/presentation/screens/outlets_lists.dart';
import 'features/signup/bloc/signup_bloc.dart';
import 'features/signup/data/data_provider/signup_api_provider.dart';
import 'features/signup/presentation/screens/sign_up.dart';
import 'features/splash_screen/bloc/splash_screen_bloc.dart';
import 'features/splash_screen/data/repository/splash_screen_repository.dart';
import 'features/splash_screen/presentation/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions().currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Client client;

  @override
  void initState() {
    super.initState();
    client = http.Client();
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark, // dark text for status bar
        statusBarBrightness: Brightness.light,
      ),
    );

    return Provider<http.Client>(
      create: (context) => client,
      child: ChangeNotifierProvider(
        create: (context) => CartChangeProvider(),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => CoreCartRepository(
                CoreStorageProvider(),
                CoreApiProvider(
                  context.read<http.Client>(),
                ),
              ),
            ),
            RepositoryProvider(
              create: (context) => SplashScreenRepository(),
            ),
            RepositoryProvider(
              create: (context) => LoginRepository(
                LoginApiProvider(context.read<http.Client>()),
                LoginSecureStorageProvider(),
              ),
            ),
            RepositoryProvider(
                create: (context) =>
                    SignupApiProvider(context.read<http.Client>())),
            RepositoryProvider(
                create: (context) =>
                    OtpRepository(OtpApiProvider(context.read<http.Client>()))),
            RepositoryProvider(
              create: (context) => OutletListRepository(
                OutletListStorageProvider(),
                OutletListApiProvider(context.read<http.Client>()),
              ),
            ),
            RepositoryProvider(
              create: (context) => OutletMenuRepository(
                OutletMenuApiProvider(context.read<http.Client>()),
                OutletMenuStorageProvider(),
              ),
            ),
            RepositoryProvider(
              create: (context) => CartRepository(
                context.read<CoreCartRepository>(),
                CartApiProvider(
                  context.read<Client>(),
                ),
              ),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SplashScreenBloc(
                    context.read<SplashScreenRepository>(),
                    context.read<http.Client>()),
              ),
              BlocProvider(create: (context) => SignInWithGoogleBloc()),
              BlocProvider(
                create: (context) => LoginBloc(context.read<LoginRepository>()),
              ),
              BlocProvider(
                create: (context) => SignupBloc(
                  context.read<SignupApiProvider>(),
                ),
              ),
              BlocProvider(
                create: (context) =>
                    OtpScreenBloc(context.read<OtpRepository>()),
              ),
              BlocProvider(
                create: (context) => OutletListBloc(
                  context.read<OutletListRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => OutletMenuBloc(
                    context.read<OutletMenuRepository>(),
                    context.read<CoreCartRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => CartBloc(
                    context.read<CoreCartRepository>(),
                    context.read<CartRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => OrdersListBloc(),
              ),
            ],
            child: MaterialApp(
              title: 'FlavR',
              theme: ThemeData(
                  //TODO: Text Theme not working
                  textTheme: GoogleFonts.poppinsTextTheme(),
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
              debugShowCheckedModeBanner: false,
              initialRoute: "/splashscreen",
              routes: {
                "/splashscreen": (context) => const SplashScreen(),
                "/signInWithGoogle": (context) => const SignInWithGoogle(),
                "/login": (context) => const LoginPage(),
                "/signUp": (context) => const SignUp(),
                "/outletList": (context) => const OutletsList(),
                "/outletMenu": (context) => const OutletMenu(),
                "/homePage": (context) => const HomePage(),
                "/profile": (context) => const ProfilePage(),
                "/payment": (context) => const Payment(),
                "/edit_profile": (context) => const EditProfile(),
                "/order_list": (context) => const OrdersList(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
