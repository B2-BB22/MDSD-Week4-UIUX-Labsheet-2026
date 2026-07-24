import 'package:flutter/material.dart';
import 'theme.dart';                 // Theme ที่ Export จาก Material Theme Builder
import 'screens/home_screen.dart';   // หน้า Home ของแอป

void main() {
  // จุดเริ่มต้นของโปรแกรม Flutter
  runApp(const MyApp());
}

///
/// MyApp เป็น Widget หลักของแอปพลิเคชัน
///
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // ------------------------------------------------------------------
    // สร้าง MaterialTheme จากไฟล์ theme.dart
    //
    // Material Theme Builder จะสร้างคลาส MaterialTheme มาให้
    // โดยต้องส่ง TextTheme เข้าไปใน Constructor
    //
    // ThemeData(useMaterial3: true).textTheme
    // คือ TextTheme มาตรฐานของ Material Design 3
    // ------------------------------------------------------------------
    final materialTheme = MaterialTheme(
      ThemeData(useMaterial3: true).textTheme,
    );

    return MaterialApp(

      // ชื่อแอปพลิเคชัน
      title: 'Green Market App',

      // ซ่อนแถบ DEBUG ที่มุมขวาบน
      debugShowCheckedModeBanner: false,

      // --------------------------------------------------------------
      // Theme สำหรับโหมด Light
      //
      // ใช้ ThemeData ที่สร้างจาก Material Theme Builder
      // ภายในประกอบด้วย
      // - ColorScheme
      // - Typography
      // - Surface Color
      // - Scaffold Background
      // และค่าต่าง ๆ ของ Material Design 3
      // --------------------------------------------------------------
      theme: materialTheme.light(),

      // --------------------------------------------------------------
      // Theme สำหรับโหมด Dark
      // --------------------------------------------------------------
      darkTheme: materialTheme.dark(),

      // --------------------------------------------------------------
      // เลือก Theme ตามการตั้งค่าของระบบปฏิบัติการ
      //
      // ThemeMode.system
      //   Light Mode -> ใช้ theme
      //   Dark Mode  -> ใช้ darkTheme
      // --------------------------------------------------------------
      themeMode: ThemeMode.system,

      // หน้าแรกของแอป
      home: const HomeScreen(),
    );
  }
}