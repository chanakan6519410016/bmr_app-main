import 'package:flutter/material.dart';
import 'package:flutter_bmr_app/views/bmr_input_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main () {
  runApp(
    FlutterBmrApp(),
  );
}

class FlutterBmrApp extends StatefulWidget {
  const FlutterBmrApp({super.key});

  @override
  State<FlutterBmrApp> createState() => _FlutterBmrAppState();
}

class _FlutterBmrAppState extends State<FlutterBmrApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmrInputUI(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme.apply(),
        ),
      ),
    );
  }
}