import 'dart:async';

import 'package:chicken_feeder/features/analysis/data/repositories/report_repository_impl.dart';
import 'package:chicken_feeder/features/analysis/domain/repositories/report_repository.dart';
import 'package:chicken_feeder/features/analysis/presentation/bloc/analysis_bloc.dart';
import 'package:chicken_feeder/features/food_capacity/data/datasources/food_container_remote_source.dart';
import 'package:chicken_feeder/features/food_capacity/data/repositories/food_container_repository_impl.dart';
import 'package:chicken_feeder/features/food_capacity/domain/repositories/food_container_repository.dart';
import 'package:chicken_feeder/features/food_capacity/domain/usecases/food_container_usecase.dart';
import 'package:chicken_feeder/features/home_page/data/datasources/feeding_schedule_remote_datasource.dart';
import 'package:chicken_feeder/features/home_page/data/repositories/feeding_schedule_repository_impl.dart';
import 'package:chicken_feeder/features/home_page/domain/repositories/feeding_schedule_repository.dart';
import 'package:chicken_feeder/features/home_page/domain/usecases/all_feeding_data_usecase.dart';
import 'package:chicken_feeder/features/home_page/presentation/bloc/feeding_schedule_bloc.dart';
import 'package:chicken_feeder/features/home_page/presentation/pages/add_feeding_schedule.dart';
import 'package:chicken_feeder/features/home_page/presentation/pages/home_page.dart';
import 'package:chicken_feeder/features/login/data/datasources/login_remote_source.dart';
import 'package:chicken_feeder/features/login/data/repositories/login_respository_impl.dart';
import 'package:chicken_feeder/features/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:chicken_feeder/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:chicken_feeder/features/sign_up/domain/usecases/sign_up_usecase.dart';
import 'package:chicken_feeder/root.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'features/analysis/data/datasources/report_remote_datasource.dart';
import 'features/analysis/domain/usecases/report_usecase.dart';
import 'features/food_capacity/presentation/bloc/food_capacity_bloc.dart';
import 'features/home_page/domain/usecases/feeding_schedule_usecase.dart';
import 'features/login/data/localdata/local_storage_data.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/login.dart';
import 'features/login/presentation/bloc/auth/authentication_bloc.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/login/presentation/pages/login_screen.dart';
import 'features/onboarding/presentation/pages/onboarding.dart';
import 'features/sign_up/data/datasources/sign_up_data_source.dart';
import 'features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'features/sign_up/presentation/pages/sign_up_page.dart';
import 'features/user/data/datasource/user_data_source.dart';
import 'features/user/data/repository/user_repository_impl.dart';
import 'features/user/domain/repository/user_repository.dart';
import 'features/user/domain/usecases/user_profile.dart';
import 'features/user/presentation/bloc/userprofile/user_profile_bloc.dart';
import 'features/utils/hidden_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final http.Client client = http.Client();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final LocalStorage data = LocalStorage(storage: storage);
    final LoginRepository loginRepository = LoginRepositoryImpl(
        loginRemoteDataSource: LoginRemoteDataSourceImpl(client: client));
    final UserProfileRepository userProfileRepository =
        UserProfileRepositoryImpl(
            localStorage: data,
            userProfileDataSource:
                UserProfileDataSourceImpl(client: client, localStorage: data));

    final FeedingScheduleRepository feedingScheduleRepository =
        FeedingScheduleRepositoryImpl(
            feedingScheduleRemoteDataSource:
                FeedingScheduleRemoteDataSourceImpl(
                    client: client, localStorage: data));

    final ReportRepository reportRepository = ReportRepositoryImpl(
        reportRepositoryRemoteDataSource:
            ReportRemoteDataSourceImpl(client: client, localStorage: data));

    final SignUpRepository signUpRepository = SignUpRepositoryImpl(
        signUpRemoteDataSource: SignUpRemoteDataSourceImpl(client: client));

    final FoodContainerRepository foodContainerRepository =
        FoodContainerRepositoryImpl(
            foodContainerRemoteDataSource: FoodContainerRemoteDataSourceImpl(
                client: client, localStorage: data));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: false,
            create: (context) =>
                AuthenticationBloc(localData: data)..add(AppStarted())),
        BlocProvider(
          lazy: false,
          create: (context) => LoginBloc(
              signInWithEmail: Login(loginRepository),
              authBloc: BlocProvider.of<AuthenticationBloc>(context)),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => UserProfileBloc(
            userProfile: UserProfile(userProfileRepository),
          ),
        ),
        BlocProvider(
          create: (context) => FeedingScheduleBloc(
              feedingScheduleUseCase: FeedingScheduleUseCase(
                  feedingScheduleRepository: feedingScheduleRepository),
              allFeedingDataUseCase: AllFeedingDataUseCase(
                  feedingScheduleRepository: feedingScheduleRepository)),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => AnalysisBloc(
              reportUseCase: ReportUseCase(reportRepository: reportRepository)),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(
              signUpUseCase: SignUpUseCase(signUpRepository: signUpRepository)),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => FoodCapacityBloc(
              foodContainerUseCase: FoodContainerUseCase(
                  foodContainerRepository: foodContainerRepository)),
          child: Container(),
        ),
      ],
      child: MaterialApp(
        title: 'Chicken Feeder',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "Poppins",
            colorScheme:
                ColorScheme.fromSwatch().copyWith(primary: Color(0xFF3B4CA6))),
        home: SplashScreen(),
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        (() => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SecondScreen()))));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            // to do SplashScreen
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
              ],
            )),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        print(state.toString());
        if (state is AuthenticationUninitialized) {
          return const Onboarding();
        }
        if (state is AuthenticationUnauthenticated) {
          if (Navigator.of(context).canPop()) {
            Navigator.pop(context);
          }
          // return const LoginScreen();
          return ScreenSignup();
        }
        if (state is AuthenticationAuthenticated) {
          context.read<UserProfileBloc>().add(LoadUserProfile());
          // if (Navigator.of(context).canPop()) {
          //   Navigator.pop(context);
          // }
          // final user = LocalStorage(storage: storage)
          // if (user.role == "admin"){
          return const HiddenDrawer();
          // }
        }
        return LoginScreen();
        // return RootPage();
      },
    );
  }
}
