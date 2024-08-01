import '../widgets/recordmap.dart';

import 'dart:async';
import 'package:flutter/material.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({Key? key}) : super(key: key);

  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  bool _isRecording = false;
  String _distance = '0.00km';
  Duration _recordingDuration = Duration.zero;
  Timer? _timer;

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _recordingDuration = Duration.zero;
      _distance = '0.00km';
    });
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _recordingDuration += Duration(seconds: 1);
      });
    });
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    _timer?.cancel();
    // Implement logic to save the recording or perform other actions
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _updateDistance(double distance) {
    setState(() {
      _distance = '${distance.toStringAsFixed(3)}km';
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Color.fromARGB(255, 17, 41, 58),
              child: Column(
                children: [
                  if (!_isRecording)
                    ElevatedButton(
                      onPressed: _startRecording,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Kayıtı Başlat',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  else
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Süre: ${_formatDuration(_recordingDuration)}',
                                style: TextStyle(color: Color.fromARGB(255, 231, 244, 255))),
                            Text('Mesafe: $_distance',
                                style: TextStyle(color: Color.fromARGB(255, 231, 244, 255))),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _stopRecording,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Kayıtı Bitir',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Expanded(
              child: RecordMap(
                isRecording: _isRecording,
                onDistanceUpdate: _updateDistance,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 17, 41, 58),
        child: SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/mainmenu');
            },
            child: const Text(
              'Ana Sayfa',
              style: TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}