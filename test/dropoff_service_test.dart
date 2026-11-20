
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:wearback_mobile/services/dropoff_service.dart';

void main() {
  group('DropoffService Tests', () {
    // TEST 1: Berhasil mengambil dan mengurutkan lokasi.
    test('Berhasil mengambil dan mengurutkan lokasi terdekat', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');

        expect(
          request.url.toString(),
          'https://overpass-api.de/api/interpreter',
        );

        return http.Response(
          jsonEncode({
            'elements': [
              {
                'type': 'node',
                'id': 101,
                'lat': -6.210000,
                'lon': 106.816666,
                'tags': {
                  'name': 'Kantor Pos Jauh',
                  'amenity': 'post_office',
                  'addr:city': 'Jakarta',
                },
              },
              {
                'type': 'node',
                'id': 102,
                'lat': -6.200000,
                'lon': 106.816666,
                'tags': {
                  'name': 'Kantor Pos Terdekat',
                  'amenity': 'post_office',
                  'addr:city': 'Jakarta',
                },
              },
              {
                'type': 'node',
                'id': 103,
                'lat': -6.205000,
                'lon': 106.816666,
                'tags': {
                  'name': 'Parcel Point',
                  'parcel_pickup': 'yes',
                },
              },
            ],
          }),
          200,
        );
      });

      final service = DropoffService(client: mockClient);

      final places = await service.getNearbyDropoffPlaces(
        latitude: -6.200000,
        longitude: 106.816666,
        radiusMeters: 5000,
      );

      // Memastikan seluruh lokasi berhasil diproses.
      expect(places.length, 3);

      // Memastikan lokasi diurutkan berdasarkan jarak.
      expect(places[0].name, 'Kantor Pos Terdekat');
      expect(places[1].name, 'Parcel Point');
      expect(places[2].name, 'Kantor Pos Jauh');

      // Lokasi dengan koordinat sama memiliki jarak 0.
      expect(places[0].distanceInMeters, 0);

      // Memastikan alamat berhasil diproses.
      expect(places[0].address, 'Jakarta');
    });

    // TEST 2: Mengabaikan lokasi tanpa koordinat.
    test('Melewati lokasi yang tidak memiliki koordinat', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'elements': [
              {
                'type': 'node',
                'id': 201,
                'tags': {
                  'name': 'Lokasi Tanpa Koordinat',
                },
              },
              {
                'type': 'node',
                'id': 202,
                'lat': -6.200000,
                'lon': 106.816666,
                'tags': {
                  'name': 'Lokasi Valid',
                },
              },
            ],
          }),
          200,
        );
      });

      final service = DropoffService(client: mockClient);

      final places = await service.getNearbyDropoffPlaces(
        latitude: -6.200000,
        longitude: 106.816666,
      );

      expect(places.length, 1);
      expect(places.first.name, 'Lokasi Valid');
    });

    // TEST 3: Menangani HTTP error.
    test('Menangani HTTP error dari Overpass API', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          'Internal Server Error',
          500,
        );
      });

      final service = DropoffService(client: mockClient);

      expect(
        service.getNearbyDropoffPlaces(
          latitude: -6.200000,
          longitude: 106.816666,
        ),
        throwsA(isA<Exception>()),
      );
    });

    // TEST 4: Mengembalikan list kosong.
    test('Mengembalikan list kosong jika tidak ada lokasi', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'elements': [],
          }),
          200,
        );
      });

      final service = DropoffService(client: mockClient);

      final places = await service.getNearbyDropoffPlaces(
        latitude: -6.200000,
        longitude: 106.816666,
      );

      expect(places, isEmpty);
    });
  });
}

