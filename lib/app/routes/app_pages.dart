import 'package:get/get.dart';

import '../modules/audio_bok/bindings/audio_book_bindings.dart';
import '../modules/audio_bok/views/audio_book_view.dart';
import '../modules/authentication/login/bindings/login_binding.dart';
import '../modules/authentication/login/views/login_view.dart';
import '../modules/authentication/lupa_pass/bindings/lupa_pass_binding.dart';
import '../modules/authentication/lupa_pass/views/lupa_pass_view.dart';
import '../modules/authentication/register/bindings/register_binding.dart';
import '../modules/authentication/register/views/register_view.dart';
import '../modules/authentication/reset_pass/bindings/reset_pass_binding.dart';
import '../modules/authentication/reset_pass/views/reset_pass_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kategori/views/kategori_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding.dart';
import '../modules/payment_buy/bindings/payment_buy_binding.dart';
import '../modules/payment_buy/views/payment_buy_view.dart';
import '../modules/payment_details/bindings/payment_details_binding.dart';
import '../modules/payment_details/views/payment_details_view.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/profile_preferenci/bindings/profile_preferenci_binding.dart';
import '../modules/profile_preferenci/views/profile_preferenci_view.dart';
import '../modules/profile_update/bindings/profile_update_binding.dart';
import '../modules/profile_update/views/profile_update_view.dart';
import '../modules/reading_book/bindings/reading_book_binding.dart';
import '../modules/reading_book/views/reading_book_view.dart';
import '../modules/riwayat/views/riwayat_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASS,
      page: () => const LupaPassView(),
      binding: LupaPassBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.KATEGORI,
      page: () => const KategoriView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => const RiwayatView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASS,
      page: () => const ResetPassView(),
      binding: ResetPassBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_UPDATE,
      page: () => const ProfileUpdateView(),
      binding: ProfileUpdateBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_DETAILS,
      page: () => const PaymentDetailsView(),
      binding: PaymentDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PREFERENCI,
      page: () => const ProfilePreferenciView(),
      binding: ProfilePreferenciBinding(),
    ),
    GetPage(
      name: _Paths.READING_BOOK,
      page: () => const ReadingBookView(),
      binding: ReadingBookBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_BUY,
      page: () => const PaymentBuyView(),
      binding: PaymentBuyBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_BUY,
      page: () => const PaymentBuyView(),
      binding: PaymentBuyBinding(),
    ),
    GetPage(
      name: _Paths.AUDIO_BOOK,
      page: () => const AudioBookView(),
      binding: AudioBookBindings(),
    ),
  ];
}
