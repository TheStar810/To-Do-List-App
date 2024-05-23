/* UAS Bahasa Pemrograman IOS, R, Kotlin
Nama Mahasiswa: William Susilo
NIM: 56220008
Kelas: T
Jurusan: Teknik Informatika
Nama Dosen: Pak Fikri Fadillah
Hari/Tanggal: Senin, 22 Januari 2024
Tentang: Pembuatan Aplikasi = Planner App
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'weather_provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => WeatherProvider(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'planT',
      theme: ThemeData.light(useMaterial3: true),
      home: const PlannerApp(),
    );
  }
}
