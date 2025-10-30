import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'autonomous.dart';

class Pregame extends StatefulWidget {
  const Pregame({super.key});

@override
_PregameAppState createState() => _PregameAppState();
}

class _PregameAppState extends State {
  String _scouterName = '';
  String _match = '';
  String _team = '';
  String _robot = 'R1';
  String _output = '';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            SizedBox(
              width: 250,
              height: 35,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _scouterName = value;
                });
              },
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Scouter Name'
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
            ],
            )
            )
              ]
            ),
             const SizedBox(height: 12,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            SizedBox(
              width: 250,
              height: 35,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _match = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Match Number'
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
            )
              ]
            ),
             const SizedBox(height: 12,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 35,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _team = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Team Number'
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height:12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Robot'),
                const SizedBox(width: 6,),
                DropdownButton(
                  value: _robot,
                  items: const [
                    DropdownMenuItem(value: 'R1', child: Text('Red 1')),
                    DropdownMenuItem(value: 'R2', child: Text('Red 2')),
                    DropdownMenuItem(value: 'R3', child: Text('Red 3')),
                    DropdownMenuItem(value: 'B1', child: Text('Blue 1')),
                    DropdownMenuItem(value: 'B2', child: Text('Blue 2')),
                    DropdownMenuItem(value: 'B3', child: Text('Blue 3')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _robot = value as String;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height:60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize:16),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    _output ='$_scouterName\t$_match\t$_team\t$_robot';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Autonomous(output1:_output)),
                    );
                  },
                  child: const Text('        Next        '),
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