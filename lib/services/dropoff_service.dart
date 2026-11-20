
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

/// Model untuk menyimpan informasi titik layanan drop-off.
class DropoffPlace {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final double distanceInMeters;

  const DropoffPlace({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.distanceInMeters,
  });
}

/// Service untuk mengambil lokasi layanan pengiriman
/// dari OpenStreetMap menggunakan Overpass API.
class DropoffService {
  static const String _overpassUrl =
      'https://overpass-api.de/api/interpreter';

  // HTTP client dapat diganti dengan MockClient saat testing.
  final http.Client _client;

  DropoffService({http.Client? client})
      : _client = client ?? http.Client();

  /// Mengambil titik layanan di sekitar koordinat pengguna.
  ///
  /// latitude       : Garis lintang pengguna.
  /// longitude      : Garis bujur pengguna.
  /// radiusMeters   : Radius pencarian dalam meter.
  ///
  /// Mengembalikan daftar DropoffPlace yang sudah
  /// diurutkan dari jarak terdekat.
  Future<List<DropoffPlace>> getNearbyDropoffPlaces({
    required double latitude,
    required double longitude,
    int radiusMeters = 5000,
  }) async {
    if (radiusMeters <= 0) {
      throw ArgumentError('Radius harus lebih besar dari 0.');
    }

    final query = '''
      [out:json][timeout:25];
      (
        nwr(around:$radiusMeters,$latitude,$longitude)
          ["amenity"~"^(parcel_locker|post_office)\$"];
        nwr(around:$radiusMeters,$latitude,$longitude)
          ["parcel_pickup"="yes"];
      );
      out center tags;
    ''';

    try {
      // Mengirim request ke Overpass API.
      final response = await _client
          .post(
            Uri.parse(_overpassUrl),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
              'data': query,
            },
          )
          .timeout(const Duration(seconds: 30));

      // Memeriksa status HTTP.
      if (response.statusCode != 200) {
        throw Exception(
          'Gagal mengambil data lokasi. '
          'HTTP ${response.statusCode}',
        );
      }

      // Mengubah JSON response menjadi Map.
      final Map<String, dynamic> result =
          jsonDecode(response.body) as Map<String, dynamic>;

      // Mengambil daftar elemen dari response.
      final List<dynamic> elements =
          result['elements'] as List<dynamic>? ?? [];

      final List<DropoffPlace> places = [];

      // Memproses setiap lokasi.
      for (final element in elements) {
        final Map<String, dynamic> item =
            Map<String, dynamic>.from(element as Map);

        final Map<String, dynamic> tags =
            Map<String, dynamic>.from(item['tags'] ?? {});

        // Node memiliki koordinat langsung.
        // Way dan relation menggunakan koordinat center.
        final Map<String, dynamic> coordinates =
            item['center'] != null
                ? Map<String, dynamic>.from(item['center'])
                : item;

        final double? placeLatitude =
            (coordinates['lat'] as num?)?.toDouble();

        final double? placeLongitude =
            (coordinates['lon'] as num?)?.toDouble();

        // Lewati lokasi yang tidak memiliki koordinat.
        if (placeLatitude == null || placeLongitude == null) {
          continue;
        }

        // Menghitung jarak dari pengguna ke lokasi.
        final double distance = Geolocator.distanceBetween(
          latitude,
          longitude,
          placeLatitude,
          placeLongitude,
        );

        // Mengambil nama lokasi.
        final String name =
            tags['name'] ??
            tags['operator'] ??
            'Titik layanan pengiriman';

        // Mengambil informasi alamat.
        final List<String> addressParts = [
          tags['addr:street'] ?? '',
          tags['addr:suburb'] ?? '',
          tags['addr:city'] ?? '',
        ].where((part) => part.toString().isNotEmpty)
            .map((part) => part.toString())
            .toList();

        final String address = addressParts.isEmpty
            ? 'Alamat tidak tersedia'
            : addressParts.join(', ');

        // Membuat objek DropoffPlace.
        places.add(
          DropoffPlace(
            id: item['id'] as int,
            name: name,
            latitude: placeLatitude,
            longitude: placeLongitude,
            address: address,
            distanceInMeters: distance,
          ),
        );
      }

      // Mengurutkan lokasi dari yang terdekat.
      places.sort(
        (a, b) => a.distanceInMeters.compareTo(
          b.distanceInMeters,
        ),
      );

      return places;
    } catch (e) {
      throw Exception(
        'Terjadi kesalahan saat mencari lokasi: $e',
      );
    }
  }
}
