import 'package:flutter/material.dart';
import 'pregame.dart';

class MatchDisplay extends StatelessWidget{
  final String finaloutput;
  static List<String> outputs = [];

  const MatchDisplay({Key? key, this.finaloutput = ''}) : super(key:key);

  @override
  Widget build(BuildContext context){
    if (finaloutput.isNotEmpty){
      outputs.add(finaloutput);
    }
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('End',
          style: TextStyle(fontSize: 20)),
          toolbarHeight: 20,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: outputs.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(outputs[index]),
                    );
                  },  
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  child: const Text('Back to Scouting'),
                ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}