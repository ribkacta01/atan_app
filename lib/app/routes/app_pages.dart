import 'package:get/get.dart';

import '../modules/beranda/bindings/beranda_binding.dart';
import '../modules/beranda/views/beranda_view.dart';
import '../modules/berandaBos/bindings/beranda_bos_binding.dart';
import '../modules/berandaBos/views/beranda_bos_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/keranjang/bindings/keranjang_binding.dart';
import '../modules/keranjang/views/keranjang_view.dart';
import '../modules/keranjangBos/bindings/keranjang_bos_binding.dart';
import '../modules/keranjangBos/views/keranjang_bos_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/olah_data_pegawai/bindings/olah_data_pegawai_binding.dart';
import '../modules/olah_data_pegawai/views/olah_data_pegawai_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/profilBos/bindings/profil_bos_binding.dart';
import '../modules/profilBos/views/profil_bos_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/tugas/bindings/tugas_binding.dart';
import '../modules/tugas/views/tugas_view.dart';
import '../modules/tugasBos/bindings/tugas_bos_binding.dart';
import '../modules/tugasBos/views/tugas_bos_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BERANDA,
      page: () => const BerandaView(),
      binding: BerandaBinding(),
    ),
    GetPage(
      name: _Paths.BERANDA_BOS,
      page: () => const BerandaBosView(),
      binding: BerandaBosBinding(),
    ),
    GetPage(
      name: _Paths.KERANJANG,
      page: () => const KeranjangView(),
      binding: KeranjangBinding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_BOS,
      page: () => const KeranjangBosView(),
      binding: KeranjangBosBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS,
      page: () => const TugasView(),
      binding: TugasBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS_BOS,
      page: () => const TugasBosView(),
      binding: TugasBosBinding(),
    ),
    GetPage(
      name: _Paths.OLAH_DATA_PEGAWAI,
      page: () => const OlahDataPegawaiView(),
      binding: OlahDataPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL_BOS,
      page: () => const ProfilBosView(),
      binding: ProfilBosBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
  ];
}
