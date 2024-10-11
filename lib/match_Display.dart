import 'package:flutter/material.dart';
import 'pregame.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MatchDisplay extends StatefulWidget {
  final String finaloutput;
  static List<String> outputs = [];

  const MatchDisplay({Key? key, this.finaloutput = ''}) : super(key: key);

  @override
  _MatchDisplayState createState() => _MatchDisplayState();
}

class _MatchDisplayState extends State<MatchDisplay> {
  List<String> selectedOutputs = [];
  String? qrData;

  @override
  void initState() {
    super.initState();
    if (widget.finaloutput.isNotEmpty) {
      MatchDisplay.outputs.add(widget.finaloutput);
    }
  }

  void _onOutputTapped(String output) {
    setState(() {
      if (selectedOutputs.contains(output)) {
        selectedOutputs.remove(output);
      } else {
        selectedOutputs.add(output);
      }
    });
  }

  void _deleteSelectedOutputs(){
    setState(() {
      MatchDisplay.outputs.removeWhere((output) => selectedOutputs.contains(output));
      selectedOutputs.clear();
    });
  }

  void _generateQrCode(){
      setState(() {
        qrData = selectedOutputs.join(',');
      });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Games Viewer',
            style: TextStyle(fontSize: 20),
          ),
          toolbarHeight: 20,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _deleteSelectedOutputs,
                    child: const Text('Delete'),
                    ),
                    ElevatedButton(
                      child: const Text ('Generate Qr code'),
                      onPressed: _generateQrCode
                    )
                ],
              ),
              if(qrData !=null)
              Padding(padding: 
              const EdgeInsets.all(16),
              child: QrImageView(
                data: qrData!,
                version: QrVersions.auto,
                size: 200,
              ),),
              Expanded(
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      MatchDisplay.outputs.isEmpty
                          ?const Center(child: Text('No matches available'))
                          :ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: MatchDisplay.outputs.length,
                              itemBuilder: (context, index) {
                                final output = MatchDisplay.outputs[index];
                                final isSelected = selectedOutputs.contains(output);
                                return ListTile(
                                  title: Text(output, style: TextStyle(fontSize: 12)),
                                  tileColor: isSelected ? Colors.blue : null,
                                  onTap: () => _onOutputTapped(output),
                                );
                              },
                            ),
                    ],
                  ),
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.all(12),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Pregame()),
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
