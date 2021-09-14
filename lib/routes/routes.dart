part of 'pages.dart';

class AppRoutes {
  static const INITIAL = AppPages.SPLASH;

  static final pages = [
    GetPage(name: _Paths.SPLASH, page: () => SplashScreen()),
    GetPage(name: _Paths.HOME, page: () => HomeScreen()),
    GetPage(name: _Paths.DETAIL_INFO, page: () => DetailInfoScreen()),
    GetPage(name: _Paths.ONBOARDING, page: () => OnBoardScreen()),
  ];
}
