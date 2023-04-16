import 'package:si_bima/views/home/detail_info_page.dart';
import 'package:si_bima/views/home/home_page.dart';
import 'package:si_bima/views/presensi/presensi_page.dart';
import 'package:si_bima/views/splash/onboard_page.dart';
import 'package:si_bima/views/splash/splash_screen.dart';
import 'package:get/route_manager.dart';


part 'routes.dart';

class AppPages {
  static const SPLASH = _Paths.SPLASH;
  static const HOME = _Paths.HOME;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const DETAIL_INFO = _Paths.DETAIL_INFO;
  static const PRESENSI = _Paths.PRESENSI;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const HOME = '/';
  static const ONBOARDING = '/onboarding';
  static const DETAIL_INFO = '/detail';
  static const PRESENSI = '/presensi';
}
