import 'package:flutter/material.dart';

void main() => runApp(const MajeedSmartAI());

class MajeedSmartAI extends StatelessWidget {
  const MajeedSmartAI({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MAJEED SMART AI',
        theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
        home: const HomeScreen(),
      );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('MAJEED SMART AI')),
        body: const Center(
          child: Text('SMART AI\nPaper Trading Mode',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      );
}
