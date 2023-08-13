import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:saffar_app/core/constants/nums.dart';
import 'package:saffar_app/core/cubits/previous_rides_cubit.dart';
import 'package:saffar_app/features/user/presenter/cubits/user_cubit.dart';
import 'package:saffar_app/core/palette.dart';
import 'package:saffar_app/core/router.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/splash/presenter/cubits/splash_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Locking app in portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Loading .env file
  await dotenv.load(fileName: '.env');

  // Initializing hive with a temp sub directory.
  await Hive.initFlutter();

  // Registers services
  await setUpServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit()),
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => PreviousRidesCubit()),
      ],
      child: MaterialApp(
        title: 'Saffar app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: Palette.lightColorScheme,
          scaffoldBackgroundColor: Palette.background,
          fontFamily: 'Nunito',
          hintColor: Palette.outline,
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent,
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Palette.primary,
            behavior: SnackBarBehavior.floating,
            contentTextStyle: TextStyle(
              color: Palette.onPrimary,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Palette.primary,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Nums.roundedCornerRadius),
                ),
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Palette.primary,
              onPrimary: Palette.onPrimary,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Nums.roundedCornerRadius),
                ),
              ),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Nums.roundedCornerRadius),
              ),
              borderSide: BorderSide(
                color: Palette.outline,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Nums.roundedCornerRadius),
              ),
              borderSide: BorderSide(
                color: Palette.outline,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Nums.roundedCornerRadius),
              ),
              borderSide: BorderSide(
                color: Palette.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Nums.roundedCornerRadius),
              ),
              borderSide: BorderSide(
                color: Palette.error,
                width: 1,
              ),
            ),
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 96,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.5,
            ),
            headline2: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w300,
              letterSpacing: -0.5,
            ),
            headline3: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w400,
            ),
            headline4: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
            headline5: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),
            subtitle1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15,
            ),
            subtitle2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
            bodyText1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            bodyText2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
            button: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
            caption: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
            ),
            overline: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5,
            ),
          ),
        ),
        onGenerateInitialRoutes: CustomRouter.onGenerateInitialRoutes,
        onGenerateRoute: CustomRouter.onGenerateRoute,
      ),
    );
  }
}
