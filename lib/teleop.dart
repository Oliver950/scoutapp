import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'endgame.dart';

class Teleop extends StatefulWidget {
  final String output1;
  final String output2;

  const Teleop({
    super.key,
    required this.output1,
    required this.output2,
  });

  @override
  State<Teleop> createState() => _TeleopState();
}

class _TeleopState extends State<Teleop> {
  String _output3 = '';

  int _fuel = 0;

  final Stopwatch _shooting = Stopwatch();
  final Stopwatch _relay = Stopwatch();
  final Stopwatch _defense = Stopwatch();

  Timer? _uiTimer;

  bool _trench = false;
  bool _bump = false;

  final List<Offset> _points = [];
  double _rotation = 0;

  @override
  void dispose() {
    _uiTimer?.cancel();
    super.dispose();
  }

  void _tickUI() {
    _uiTimer ??= Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (mounted) setState(() {});
    });
  }

  void _stopAllTimers() {
    _shooting.stop();
    _relay.stop();
    _defense.stop();
    _uiTimer?.cancel();
    _uiTimer = null;
  }

  void _startOnly(Stopwatch s) {
    _shooting.stop();
    _relay.stop();
    _defense.stop();
    s.start();
    _tickUI();
    setState(() {});
  }

  void _stopTimer(Stopwatch s) {
    s.stop();
    if (!_shooting.isRunning && !_relay.isRunning && !_defense.isRunning) {
      _uiTimer?.cancel();
      _uiTimer = null;
    }
    setState(() {});
  }

  void _next() {
    _stopAllTimers();

    _output3 =
    '$_fuel\t'
        '${_points.map((p) => '${p.dx.toStringAsFixed(2)},${p.dy.toStringAsFixed(2)}').join(';')}\t'
        '${_shooting.elapsed.inSeconds}\t'
        '${_relay.elapsed.inSeconds}\t'
        '${_defense.elapsed.inSeconds}\t'
        '${_trench ? 1 : 0}\t'
        '${_bump ? 1 : 0}';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Endgame(
          output3: _output3,
          output2: widget.output2,
          output1: widget.output1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Teleop'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Fuel per second',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => setState(() {
                                  _fuel = max(0, _fuel - 2);
                                }),
                                child: const Text('-2'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => setState(() {
                                  _fuel = max(0, _fuel - 1);
                                }),
                                child: const Text('-1'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: scheme.outlineVariant),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$_fuel',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => setState(() {
                                  _fuel += 1;
                                }),
                                child: const Text('+1'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => setState(() {
                                  _fuel += 2;
                                }),
                                child: const Text('+2'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Tap shots on the field',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: GestureDetector(
                            onTapDown: (details) {
                              setState(() => _points.add(details.localPosition));
                            },
                            child: Stack(
                              children: [
                                Transform.rotate(
                                  angle: _rotation,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/2026Field.png',
                                      width: 356.5,
                                      height: 174,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                ..._points.map(
                                      (p) => Positioned(
                                    left: p.dx - 5,
                                    top: p.dy - 5,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: scheme.error,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              tooltip: 'Rotate 180°',
                              icon: const Icon(Icons.rotate_left),
                              onPressed: () => setState(() => _rotation += pi),
                            ),
                            IconButton(
                              tooltip: 'Undo last tap',
                              icon: const Icon(Icons.undo),
                              onPressed: _points.isNotEmpty
                                  ? () => setState(() => _points.removeLast())
                                  : null,
                            ),
                            IconButton(
                              tooltip: 'Clear',
                              icon: const Icon(Icons.delete_outline),
                              onPressed: _points.isNotEmpty
                                  ? () => setState(() => _points.clear())
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Timers',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),

                        _TimerRow(
                          label: 'Time shooting',
                          seconds: _shooting.elapsed.inSeconds,
                          running: _shooting.isRunning,
                          onStart: () => _startOnly(_shooting),
                          onStop: () => _stopTimer(_shooting),
                        ),
                        const SizedBox(height: 10),
                        _TimerRow(
                          label: 'Time relaying fuel',
                          seconds: _relay.elapsed.inSeconds,
                          running: _relay.isRunning,
                          onStart: () => _startOnly(_relay),
                          onStop: () => _stopTimer(_relay),
                        ),
                        const SizedBox(height: 10),
                        _TimerRow(
                          label: "Time in opponent's zone",
                          seconds: _defense.elapsed.inSeconds,
                          running: _defense.isRunning,
                          onStart: () => _startOnly(_defense),
                          onStop: () => _stopTimer(_defense),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Trench'),
                          value: _trench,
                          onChanged: (v) => setState(() => _trench = v),
                        ),
                        SwitchListTile(
                          title: const Text('Bump'),
                          value: _bump,
                          onChanged: (v) => setState(() => _bump = v),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),


                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                        onPressed: () {
                          _stopAllTimers();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                        onPressed: _next,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerRow extends StatelessWidget {
  final String label;
  final int seconds;
  final bool running;
  final VoidCallback onStart;
  final VoidCallback onStop;

  const _TimerRow({
    required this.label,
    required this.seconds,
    required this.running,
    required this.onStart,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Container(
          width: 64,
          alignment: Alignment.center,
          child: Text(
            '${seconds}s',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: running ? null : onStart,
          child: const Text('Start'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: running ? onStop : null,
          child: const Text('Stop'),
        ),
      ],
    );
  }
}