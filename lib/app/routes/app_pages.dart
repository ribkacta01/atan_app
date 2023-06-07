import 'package:get/get.dart';

import '../modules/beranda/bindings/beranda_binding.dart';
import '../modules/beranda/views/beranda_view.dart';
import '../modules/berandaBos/bindings/beranda_bos_binding.dart';
import '../modules/berandaBos/views/beranda_bos_view.dart';
import '../modules/edit_item/bindings/edit_item_binding.dart';
import '../modules/edit_item/views/edit_item_view.dart';
import '../modules/edit_pegawai/bindings/edit_pegawai_binding.dart';
import '../modules/edit_pegawai/views/edit_pegawai_view.dart';
import '../modules/edit_profBos/bindings/edit_prof_bos_binding.dart';
import '../modules/edit_profBos/views/edit_prof_bos_view.dart';
import '../modules/edit_profKry/bindings/edit_prof_kry_binding.dart';
import '../modules/edit_profKry/views/edit_prof_kry_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/item_pesanan_kry/bindings/item_pesanan_kry_binding.dart';
import '../modules/item_pesanan_kry/views/item_pesanan_kry_view.dart';
import '../modules/keranjang/bindings/keranjang_binding.dart';
import '../modules/keranjang/views/keranjang_view.dart';
import '../modules/keranjangBos/bindings/keranjang_bos_binding.dart';
import '../modules/keranjangBos/views/keranjang_bos_view.dart';
import '../modules/list_kebutuhan/bindings/list_kebutuhan_binding.dart';
import '../modules/list_kebutuhan/views/list_kebutuhan_view.dart';
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
import '../modules/tambah_foto/bindings/tambah_foto_binding.dart';
import '../modules/tambah_foto/views/tambah_foto_view.dart';
import '../modules/tambah_item/bindings/tambah_item_binding.dart';
import '../modules/tambah_item/views/tambah_item_view.dart';
import '../modules/tambah_pegawai/bindings/tambah_pegawai_binding.dart';
import '../modules/tambah_pegawai/views/tambah_pegawai_view.dart';
import '../modules/tambah_pemesan/bindings/tambah_pemesan_binding.dart';
import '../modules/tambah_pemesan/views/tambah_pemesan_view.dart';
import '../modules/tambah_tugas/bindings/tambah_tugas_binding.dart';
import '../modules/tambah_tugas/views/tambah_tugas_view.dart';
import '../modules/tugas/bindings/tugas_binding.dart';
import '../modules/tugas/views/tugas_view.dart';
import '../modules/tugasBos/bindings/tugas_bos_binding.dart';
import '../modules/tugasBos/views/tugas_bos_view.dart';
import '../modules/tugas_selesai/bindings/tugas_selesai_binding.dart';
import '../modules/tugas_selesai/views/tugas_selesai_view.dart';

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
      page: () => KeranjangBosView(),
      binding: KeranjangBosBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS,
      page: () => const TugasView(),
      binding: TugasBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS_BOS,
      page: () => TugasBosView(),
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
    GetPage(
      name: _Paths.EDIT_PROF_KRY,
      page: () => const EditProfKryView(),
      binding: EditProfKryBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROF_BOS,
      page: () => const EditProfBosView(),
      binding: EditProfBosBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_PEMESAN,
      page: () => const TambahPemesanView(),
      binding: TambahPemesanBinding(),
    ),
    GetPage(
      name: _Paths.LIST_KEBUTUHAN,
      page: () => const ListKebutuhanView(),
      binding: ListKebutuhanBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_TUGAS,
      page: () => const TambahTugasView(),
      binding: TambahTugasBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_PEGAWAI,
      page: () => const TambahPegawaiView(),
      binding: TambahPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.ITEM_PESANAN_KRY,
      page: () => const ItemPesananKryView(),
      binding: ItemPesananKryBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PEGAWAI,
      page: () => const EditPegawaiView(),
      binding: EditPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_ITEM,
      page: () => const TambahItemView(),
      binding: TambahItemBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ITEM,
      page: () => const EditItemView(),
      binding: EditItemBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_FOTO,
      page: () => const TambahFotoView(),
      binding: TambahFotoBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS_SELESAI,
      page: () => const TugasSelesaiView(),
      binding: TugasSelesaiBinding(),
    ),
  ];
}
