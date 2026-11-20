# WearBack Mobile

**"Wear It Back, Give It Back"**

WearBack adalah platform marketplace pakaian preloved yang membantu pengguna menjual pakaian yang masih layak pakai dengan mudah, sekaligus memberi kesempatan kedua bagi fashion item untuk terus dipakai. Pakaian yang menumpuk di lemari dapat menjadi penghasilan tambahan bagi penjual dan pilihan fashion yang lebih terjangkau serta ramah lingkungan bagi pembeli. Versi mobile melanjutkan cakupan website: katalog/listing pakaian, transaksi, ulasan dan rating, pencarian titik drop-off, serta autentikasi dan profil. Auction menjadi fitur tambahan dalam marketplace, dengan penanggung jawab Hudzaifah (Uza).

WearBack Mobile merupakan aplikasi Flutter yang terhubung ke [situs web WearBack](https://hudzaifah51-wearback.pws.cs.ui.ac.id). Data aplikasi dikelola oleh backend Django yang sama dengan situs web dan akan diakses melalui web service **Django REST Framework (DRF)**.

Proyek ini dibuat untuk memenuhi tugas **Proyek Akhir Semester - Pemrograman Berbasis Platform (CSGE602022)**, Fakultas Ilmu Komputer, Universitas Indonesia, Semester Gasal 2026/2027, dengan tema **Sustainable Living** (subtema: **Slow Fashion & Conscious Shopping**).

### Manfaat bagi Masyarakat

- Mengurangi limbah tekstil dengan memperpanjang siklus pakai pakaian.
- Membuka peluang penghasilan tambahan bagi penjual pakaian bekas.
- Menyediakan alternatif belanja fashion yang lebih terjangkau dan berkelanjutan.
- Memudahkan pengguna menemukan titik drop-off/mitra pengiriman terdekat.

### Status Pengembangan

Pada pengerjaan lokal saat ini, halaman utama Flutter dan navigasi menuju halaman dasar Ulasan & Rating sudah dibuat. Halaman ulasan belum mengambil data dari backend. API daftar ulasan pada Django lokal sudah diverifikasi mengembalikan HTTP 200 setelah login; status deployment API di PWS belum diverifikasi. Modul lain mengikuti pembagian di bawah dan status implementasinya perlu dikonfirmasi oleh masing-masing PIC. Fitur website tidak otomatis berarti fitur Flutter sudah selesai.

## Anggota Kelompok

| Nama | NPM |
| --- | --- |
| Niccola Geraldo Winaryo Durand | 2506619070 |
| Fathir Azka Dillafah | 2506539523 |
| Hudzaifah | 2506622840 |
| Albert Timmothy Ariajaya (Project Manager) | 2506656381 |
| Lynorexly Imanuel Tatipikalawan | 2506546932 |

## Daftar Modul & Pembagian Kerja

Pembagian mobile mengikuti modul website yang sudah dikerjakan. Auction merupakan tambahan tanggung jawab Hudzaifah (Uza), bukan pengganti fokus marketplace atau modul anggota lainnya.

| No. | Modul | Tanggung Jawab | PIC | Prioritas |
| --- | --- | --- | --- | --- |
| 1 | Autentikasi & Profil, serta Auction | Registrasi, login, logout, profil, dan integrasi sesi pengguna; tambahan fokus auction mencakup halaman lelang, penawaran, riwayat penawaran, waktu berakhir, serta hasil lelang yang ditentukan backend. | Hudzaifah (Uza) | Esensial |
| 2 | Katalog & Listing Pakaian | Menampilkan, mencari, dan memfilter pakaian; detail produk; membuat, mengubah, dan menghapus listing milik penjual sesuai aturan backend. | Niccola Geraldo Winaryo Durand | Esensial |
| 3 | Ulasan & Rating Penjual | Menambah ulasan setelah transaksi completed; melihat, mengedit, menghapus, dan memfilter ulasan milik pengguna; menampilkan rating sesuai data backend. | Albert Timmothy Ariajaya | Esensial |
| 4 | Transaksi & Riwayat | Keranjang, checkout, detail pesanan, alur pembayaran, status pesanan, serta riwayat pembelian dan penjualan. | Fathir Azka Dillafah | Esensial |
| 5 | Lokasi Drop-off & Pengiriman | Menampilkan dan mencari titik drop-off/mitra pengiriman terdekat berdasarkan lokasi, termasuk integrasi peta dan data lokasi sesuai backend website. | Lynorexly Imanuel Tatipikalawan | Esensial |

Setiap PIC bertanggung jawab atas halaman Flutter modulnya, widget layout dan input, event handling, pemanggilan API secara asinkron, serta pengolahan respons JSON. PIC juga mengembangkan endpoint DRF modul terkait, termasuk serializer dan view/viewset, di repositori Django.

### Batas Tanggung Jawab Antarmodul

- **Katalog & Listing** menyediakan data pakaian yang digunakan transaksi, ulasan, dan auction. PIC modul lain menggunakan relasi atau ID listing dari backend.
- **Transaksi & Riwayat** mengelola pembelian serta status pesanan. **Ulasan & Rating** memeriksa transaksi milik pembeli dengan status completed sebelum menerima ulasan.
- **Ulasan & Rating** menjadi tanggung jawab Albert; halaman katalog dapat memakai ringkasan rating dari endpoint ulasan tanpa memindahkan kepemilikan modul.
- **Autentikasi & Profil** menyediakan sesi pengguna bersama untuk seluruh modul. Setiap endpoint tetap memeriksa izin dan kepemilikan data.
- **Auction** menjadi tambahan fokus Uza. Validitas penawaran, waktu berakhir, dan hasil lelang ditentukan backend; integrasi transaksi hasil lelang dikoordinasikan dengan Fathir.
- **Lokasi Drop-off & Pengiriman** menyediakan pencarian lokasi; pengelolaan pesanan tetap berada di modul transaksi.

## Sumber Data

- **Backend utama:** proyek [WearBack Django](https://github.com/F09-PBP-26/wearback), yang digunakan bersama oleh situs web dan aplikasi mobile.
- **Data aplikasi:** akun, profil, listing pakaian, transaksi, ulasan/rating, data drop-off, serta lelang dan penawaran diakses melalui backend Django dan endpoint DRF.
- **Peta/lokasi:** OpenStreetMap menjadi referensi integrasi lokasi dari website; penerapan Flutter menjadi tanggung jawab PIC drop-off.
- **Data produk awal:** website menggunakan dataset sintetis listing pakaian yang di-seed ke database. Aplikasi mobile membaca data backend, bukan menyalin dataset statis ke kode Flutter.
- **Data pengujian:** data contoh disiapkan di backend agar alur situs web dan mobile dapat diuji menggunakan sumber data yang sama. Data statis di Flutter tidak digunakan sebagai pengganti integrasi API.

## Peran Pengguna

1. **Pengguna Umum (belum login)** dapat melihat listing dan informasi publik sesuai izin backend; transaksi dan data kontak pribadi memerlukan login.
2. **Pembeli** dapat menjelajahi pakaian, bertransaksi, melihat riwayat pembelian, memberi ulasan setelah transaksi completed, mencari drop-off, dan mengikuti auction.
3. **Penjual** dapat mengelola listing miliknya, memproses pesanan, melihat ulasan pembeli, serta menggunakan fitur auction sesuai aturan backend.

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

1. Flutter meminta data melalui endpoint modul, misalnya listing pakaian, daftar ulasan, titik drop-off, detail lelang, atau riwayat transaksi.
2. View/viewset DRF memeriksa akses, mengambil data dari database, dan mengembalikan JSON melalui serializer.
3. Flutter mengolah JSON menjadi model Dart dan menampilkan hasilnya, termasuk kondisi memuat, data kosong, dan kegagalan permintaan.
4. Untuk tindakan seperti membuat listing, mengirim ulasan, mengajukan penawaran, atau mengubah profil, Flutter mengirimkan data melalui metode HTTP sesuai kontrak endpoint.
5. Backend memvalidasi permintaan dan menyimpan perubahan. Flutter menggunakan respons atau memuat ulang data terkait untuk memperbarui tampilan.

Permintaan yang memerlukan login menyertakan informasi autentikasi sesuai mekanisme yang ditetapkan backend. Kontrak autentikasi dan konfigurasi alamat API akan didokumentasikan ketika implementasinya tersedia.

### Integrasi Antarmodul

Penjual mengunggah pakaian melalui modul katalog/listing. Pembeli memilih pakaian dan melakukan checkout melalui modul transaksi. Setelah transaksi completed, pembeli dapat menulis ulasan yang terhubung dengan transaksi dan listing tersebut. Modul lokasi membantu pengguna menemukan titik drop-off/pengiriman. Auction menyediakan alur penawaran tambahan pada marketplace, dengan hasil dari backend yang diintegrasikan ke transaksi sesuai kontrak antarmodul.

Saat demo, data dari website harus dapat dibaca oleh mobile, dan perubahan melalui mobile harus tersimpan di backend yang sama sehingga dapat dilihat kembali melalui website.

### Status Endpoint

Konvensi backend pada README website yang diberikan memakai awalan `/api/v1/`, autentikasi sesi, CSRF untuk operasi perubahan data, serta paginasi default 20 item. Implementasi ulasan lokal yang dibuat pada tahap awal masih memakai `/api/reviews/` dan paginasi 10 item. Perbedaan ini harus diselaraskan dengan konfigurasi backend kelompok sebelum integrasi final; dokumentasi ini tidak menyatakan URL `/api/v1/reviews/` sudah tersedia.

| Metode | Endpoint saat ini | Fungsi | Autentikasi | Status |
| --- | --- | --- | --- | --- |
| GET | `/api/reviews/` | Daftar ulasan milik pengguna; respons count, next, previous, results | Sesi login | HTTP 200 dan data JSON sudah diverifikasi di backend lokal |
| GET | `/api/reviews/<id>/` | Detail ulasan milik pengguna | Sesi login | Kode tersedia; uji manual detail belum dikonfirmasi |

API tambah/edit/hapus ulasan dan integrasi sesi pada Flutter belum selesai. Endpoint modul lainnya perlu didokumentasikan oleh PIC masing-masing setelah diverifikasi. Status API lokal tidak menyatakan API sudah di-deploy ke PWS.

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

Pada kode lokal saat ini, aplikasi menampilkan halaman utama WearBack dengan navigasi ke halaman dasar Ulasan & Rating. Aplikasi belum memiliki konfigurasi alamat API maupun koneksi ke PWS. Setelah integrasi tersedia, panduan ini akan dilengkapi dengan konfigurasi backend yang benar-benar digunakan oleh kode.

Untuk menyiapkan backend lokal, ikuti [petunjuk instalasi pada README Django](https://github.com/F09-PBP-26/wearback/blob/main/README.md). Backend Django dikelola di repositori terpisah.

### Pemeriksaan dan Pengujian

```bash
flutter analyze
flutter test
```

Tes widget bawaan penghitung perlu disesuaikan dengan halaman utama yang baru. Pengujian modul dan integrasi akan ditambahkan bersama implementasinya; seluruh tes belum dinyatakan lolos.

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
