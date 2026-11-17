# WearBack Mobile

**"Wear It Back, Give It Back"**

WearBack adalah platform lelang pakaian preloved yang membantu pengguna menjual pakaian yang masih layak pakai dan memberi kesempatan kedua bagi fashion item untuk terus digunakan. Pengguna dapat menemukan lelang, mengajukan penawaran, serta menyelesaikan transaksi setelah memenangkan lelang. Pakaian yang menumpuk di lemari dapat menjadi penghasilan tambahan bagi penjual sekaligus pilihan fashion yang lebih terjangkau dan berkelanjutan bagi pembeli.

WearBack Mobile merupakan aplikasi Flutter yang terhubung ke [situs web WearBack](https://hudzaifah51-wearback.pws.cs.ui.ac.id). Data aplikasi dikelola oleh backend Django yang sama dengan situs web dan akan diakses melalui web service **Django REST Framework (DRF)**.

Proyek ini dibuat untuk memenuhi tugas **Proyek Akhir Semester - Pemrograman Berbasis Platform (CSGE602022)**, Fakultas Ilmu Komputer, Universitas Indonesia, Semester Gasal 2026/2027, dengan tema **Sustainable Living** (subtema: **Slow Fashion & Conscious Shopping**).

### Manfaat bagi Masyarakat

- Mengurangi limbah tekstil dengan memperpanjang siklus pakai pakaian.
- Membuka peluang penghasilan tambahan bagi penjual pakaian bekas.
- Menyediakan alternatif belanja fashion yang lebih terjangkau dan berkelanjutan.

### Status Pengembangan

Repositori saat ini berisi kerangka awal Flutter dengan aplikasi penghitung bawaan. Lima modul, halaman navigasi, serta integrasi DRF yang dijelaskan di bawah merupakan cakupan pengembangan dan belum diimplementasikan pada aplikasi mobile. Daftar endpoint yang sudah berjalan, desain mobile, dan tautan APK akan diperbarui mengikuti perkembangan proyek.

## Anggota Kelompok

| Nama | NPM |
| --- | --- |
| Niccola Geraldo Winaryo Durand | 2506619070 |
| Fathir Azka Dillafah | 2506539523 |
| Hudzaifah | 2506622840 |
| Albert Timmothy Ariajaya (Project Manager) | 2506656381 |
| Lynorexly Imanuel Tatipikalawan | 2506546932 |

## Daftar Modul & Pembagian Kerja

Pembagian berikut menjadi acuan pengembangan versi mobile dengan fokus lelang. Seluruh modul berprioritas **esensial** dan saat ini berstatus **direncanakan**.

| No. | Modul | Tanggung Jawab | PIC | Prioritas |
| --- | --- | --- | --- | --- |
| 1 | Autentikasi & Profil | Registrasi, login, logout, melihat dan mengubah profil, serta mengelola alamat pengiriman pengguna. | Hudzaifah | Esensial |
| 2 | Eksplorasi Lelang | Menjelajahi katalog lelang, pencarian, kategori, filter, pengurutan, paginasi, serta menambah, melihat, dan menghapus lelang dari daftar pantauan pribadi (watchlist). | Lynorexly Imanuel Tatipikalawan | Esensial |
| 3 | Detail Lelang & Penawaran | Detail lelang, pengajuan penawaran, penawaran tertinggi, riwayat penawaran, hitung mundur, serta penetapan hasil lelang melalui backend. | Albert Timmothy Ariajaya | Esensial |
| 4 | Manajemen Lelang Penjual | Membuat, mengubah, dan mengelola lelang milik sendiri, termasuk informasi pakaian, foto, harga awal, kelipatan minimum penawaran, jadwal, dan status publikasi. | Niccola Geraldo Winaryo Durand | Esensial |
| 5 | Transaksi & Riwayat | Lelang yang dimenangkan, detail transaksi, alamat pengiriman pesanan, status pembayaran dan pesanan, serta riwayat pembelian dan penjualan. | Fathir Azka Dillafah | Esensial |

Setiap PIC bertanggung jawab atas halaman Flutter modulnya, widget layout dan input, event handling, pemanggilan API secara asinkron, serta pengolahan respons JSON. PIC juga mengembangkan endpoint DRF modul terkait, termasuk serializer dan view/viewset, di repositori Django.

### Batas Tanggung Jawab Antarmodul

- **Eksplorasi Lelang** menangani penemuan lelang dan daftar pantauan; perubahan informasi lelang menjadi tanggung jawab **Manajemen Lelang Penjual**.
- **Detail Lelang & Penawaran** menangani interaksi peserta dan hasil lelang. Backend menentukan validitas penawaran, waktu berakhir, dan pemenang; hitung mundur Flutter mengikuti waktu dari server.
- **Manajemen Lelang Penjual** mengatur data dan publikasi lelang milik penjual, termasuk pembatasan perubahan setelah penawaran masuk.
- **Transaksi & Riwayat** menggunakan hasil lelang yang telah ditetapkan backend untuk membentuk transaksi pemenang dan menangani proses setelah lelang berakhir.
- **Autentikasi & Profil** menyimpan alamat pengguna. **Transaksi & Riwayat** menyimpan salinan alamat yang dipilih pada pesanan agar riwayat pengiriman tetap sesuai transaksi tersebut.

## Sumber Data

- **Backend utama:** proyek [WearBack Django](https://github.com/F09-PBP-26/wearback), yang digunakan bersama oleh situs web dan aplikasi mobile.
- **Data aplikasi:** akun, profil, alamat, pakaian, lelang, penawaran, daftar pantauan, dan transaksi akan disimpan di database backend Django serta diakses melalui endpoint DRF.
- **Data pengujian:** data contoh disiapkan di backend agar alur situs web dan mobile dapat diuji menggunakan sumber data yang sama. Data statis di Flutter tidak digunakan sebagai pengganti integrasi API.

## Peran Pengguna

1. **Pengguna Umum (belum login)** dapat menjelajahi katalog, mencari dan memfilter lelang, serta melihat informasi lelang yang bersifat publik. Pengajuan penawaran, daftar pantauan pribadi, dan transaksi memerlukan login.
2. **Pembeli/Peserta Lelang** dapat mengelola profil dan alamat, menyimpan lelang ke daftar pantauan, mengajukan penawaran, melihat hasil lelang, serta mengakses transaksi dan riwayat pembeliannya.
3. **Penjual** dapat membuat dan mengelola lelang miliknya, memantau penawaran dan hasil lelang, serta mengelola pesanan dan riwayat penjualan terkait.

Pembeli dan penjual merupakan peran dalam penggunaan fitur; satu akun dapat melakukan keduanya. Backend memeriksa autentikasi, kepemilikan data, dan izin tindakan pada setiap permintaan yang memerlukannya.

## Alur Pengintegrasian Data

Integrasi dirancang menggunakan Flutter sebagai antarmuka mobile dan Django REST Framework pada situs web PWS sebagai penyedia API. Seluruh perubahan data akan disimpan di backend yang sama agar dapat dibaca kembali melalui situs web maupun aplikasi mobile.

```text
Interaksi pengguna pada halaman Flutter
    -> Permintaan HTTP asinkron ke endpoint DRF pada PWS
    -> Pemeriksaan autentikasi, izin, dan validasi data di Django
    -> Pembacaan atau perubahan database bersama
    -> Respons JSON dari serializer DRF
    -> Pengolahan model Dart dan pembaruan tampilan Flutter
```

### Pembacaan dan Perubahan Data

1. Flutter meminta data melalui endpoint modul, misalnya katalog lelang, detail penawaran, atau riwayat transaksi.
2. View/viewset DRF memeriksa akses, mengambil data dari database, dan mengembalikan JSON melalui serializer.
3. Flutter mengolah JSON menjadi model Dart dan menampilkan hasilnya, termasuk kondisi memuat, data kosong, dan kegagalan permintaan.
4. Untuk tindakan seperti membuat lelang, menawar, atau mengubah alamat, Flutter mengirimkan data melalui metode HTTP sesuai kontrak endpoint.
5. Backend memvalidasi permintaan dan menyimpan perubahan. Flutter menggunakan respons atau memuat ulang data terkait untuk memperbarui tampilan.

Permintaan yang memerlukan login menyertakan informasi autentikasi sesuai mekanisme yang ditetapkan backend. Kontrak autentikasi dan konfigurasi alamat API akan didokumentasikan ketika implementasinya tersedia.

### Integrasi Antarmodul

Penjual membuat dan menerbitkan lelang melalui modul Manajemen Lelang Penjual. Lelang tersebut muncul pada Eksplorasi Lelang, lalu peserta membuka detail dan mengajukan penawaran melalui modul Detail Lelang & Penawaran. Setelah lelang berakhir, backend menetapkan hasilnya. Modul Transaksi & Riwayat menggunakan hasil tersebut untuk menyediakan transaksi pemenang dan proses pesanan berikutnya.

Saat demo integrasi, lelang yang dibuat melalui situs web harus dapat dibaca di mobile. Penawaran dan perubahan data yang dikirim melalui mobile juga harus dapat dibaca kembali melalui situs web.

### Status Endpoint

Daftar endpoint DRF per modul belum tersedia dalam dokumentasi ini. URL, metode HTTP, format permintaan/respons, dan kebutuhan autentikasi akan dicantumkan setelah endpoint diverifikasi pada backend. Penjelasan integrasi di atas merupakan rancangan, bukan pernyataan bahwa API sudah berjalan.

## Cara Menjalankan Proyek

### Prasyarat

- [Flutter SDK](https://docs.flutter.dev/get-started/install) dengan Dart yang memenuhi batas versi `^3.13.7` pada `pubspec.yaml` (Dart 3.13.7 atau lebih baru, sebelum 4.0.0).
- [Git](https://git-scm.com/).
- Android SDK serta emulator atau perangkat Android yang dapat digunakan oleh Flutter.

### Langkah Instalasi

1. **Klon repositori** dan masuk ke direktori proyek.

   ```bash
   git clone https://github.com/F09-PBP-26/WearBack-Mobile.git
   cd WearBack-Mobile
   ```

2. **Periksa lingkungan pengembangan** dan selesaikan konfigurasi yang diperlukan untuk menjalankan aplikasi Android.

   ```bash
   flutter doctor
   ```

3. **Pasang dependensi.**

   ```bash
   flutter pub get
   ```

4. **Jalankan emulator atau hubungkan perangkat**, lalu periksa perangkat yang tersedia.

   ```bash
   flutter devices
   ```

5. **Jalankan aplikasi.**

   ```bash
   flutter run
   ```

Saat ini langkah tersebut menjalankan aplikasi penghitung bawaan Flutter. Aplikasi belum memiliki konfigurasi alamat API maupun koneksi ke PWS. Setelah integrasi tersedia, panduan ini akan dilengkapi dengan konfigurasi backend yang benar-benar digunakan oleh kode.

Untuk menyiapkan backend lokal, ikuti [petunjuk instalasi pada README Django](https://github.com/F09-PBP-26/wearback/blob/main/README.md). Backend Django dikelola di repositori terpisah.

### Pemeriksaan dan Pengujian

```bash
flutter analyze
flutter test
```

Pengujian yang tersedia saat ini masih berupa pengujian widget aplikasi penghitung bawaan. Pengujian modul dan integrasi akan ditambahkan bersama implementasinya.

### Membangun APK

```bash
flutter build apk --release
```

APK hasil build berada di `build/app/outputs/flutter-apk/app-release.apk`. Sebelum distribusi, konfigurasi rilis Android dan logo aplikasi WearBack perlu disiapkan. APK final akan diunggah sebagai aset GitHub Release dan tersedia melalui Bitrise; tautan unduhan akan ditambahkan di bawah.

## Tautan Terkait

| Kebutuhan | Tautan atau Status |
| --- | --- |
| Repositori mobile | [WearBack Mobile](https://github.com/F09-PBP-26/WearBack-Mobile) |
| Repositori backend dan situs web | [WearBack Django](https://github.com/F09-PBP-26/wearback) |
| Situs web PWS | [WearBack PWS](https://hudzaifah51-wearback.pws.cs.ui.ac.id) |
| Desain Figma mobile | Belum tersedia; akan ditambahkan setelah rancangan mobile tersedia. |
| Referensi desain dari proyek web | [Figma WearBack PTS](https://ristek.link/PBP2026-F09-Figma); belum diverifikasi mencakup rancangan mobile. |
| APK di GitHub Releases | Belum tersedia; tautan langsung APK akan ditambahkan setelah rilis. |
| APK di Bitrise | Belum tersedia; tautan distribusi akan ditambahkan setelah rilis. |
| Video promosi (bonus) | Belum tersedia. |

## Tahapan Pengumpulan

| Tahap | Tenggat (WIB) | Target |
| --- | --- | --- |
| Checkpoint 1 | 20 November 2026, 23.59 | Repositori dan README, pembagian modul, daftar endpoint DRF yang sudah berjalan, serta halaman tiap modul dengan navigasi. Tautan Figma dan APK boleh menyusul. |
| Pengumpulan akhir | 9 Desember 2026, 23.59 | Seluruh modul terintegrasi dengan API sesuai desain, tautan Figma dan APK dilengkapi, serta APK dirilis di GitHub Releases dan Bitrise. Video promosi ditambahkan bila mengerjakan bonus. |

_Proyek Akhir Semester PBP Gasal 2026/2027 - Fakultas Ilmu Komputer Universitas Indonesia_
