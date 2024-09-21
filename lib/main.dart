import 'dart:core';
import 'package:flutter/material.dart';
import 'package:scoutapp/pregame.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Scouting App',
      home:MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

@override
_MainAppState createState() => _MainAppState();
}

class _MainAppState extends State {
@override
Widget build(BuildContext context) {
  return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor:Colors.blue),
          textTheme: const TextTheme(
          bodyMedium:TextStyle(fontSize: 16),
          bodyLarge: TextStyle(fontSize: 12),
          bodySmall: TextStyle(fontSize: 12)
          )
        ),
      home:Scaffold(
        appBar: AppBar(
          title: const Text('ScoutingApp',
          style: TextStyle(
            fontSize: 20,
          ),
          ),
          toolbarHeight: 25,
          backgroundColor: Colors.blue,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Oakbotics Scouting App',
            style: TextStyle(
              fontSize: 24
            )),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize:16),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Pregame()),
                    );
                  },
                  child: const Text('        Scouting        '),
                )
                  ],
                )
                
              ],
            )
        ],
      ),
    ),
  ),
  );
}
}