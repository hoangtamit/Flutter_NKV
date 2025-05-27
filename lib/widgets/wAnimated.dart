import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final int targetNumber;
  final Duration duration;
  final TextStyle? textStyle;

  const AnimatedCounter({
    super.key,
    required this.targetNumber,
    this.duration = const Duration(seconds: 2),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetNumber.toDouble()),
      duration: duration,
      builder: (context, value, child) {
        return Text(
          value.toInt().toString(),
          style: textStyle ?? const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        );
      },
    );
  }
}

class AnimatedTextFieldCounter extends StatefulWidget {
  final String label;
  final int targetNumber;
  final Duration duration;

  const AnimatedTextFieldCounter({
    super.key,
    required this.label,
    required this.targetNumber,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<AnimatedTextFieldCounter> createState() => _AnimatedTextFieldCounterState();
}

class _AnimatedTextFieldCounterState extends State<AnimatedTextFieldCounter> {
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int _currentNumber = 0;

  @override
  void initState() {
    super.initState();
    _startCounting();
  }

  void _startCounting() {
    int totalSteps = 0;
    if( widget.targetNumber == null ||  widget.targetNumber == '')
      totalSteps = 0;
    else
     totalSteps = widget.targetNumber;
    if(totalSteps > 0) {
      int millisecondsPerStep = (widget.duration.inMilliseconds / totalSteps).round();
      _timer = Timer.periodic(Duration(milliseconds: millisecondsPerStep), (timer) {
        if (_currentNumber >= widget.targetNumber) {
          _timer?.cancel();
        } else {
          setState(() {
            _currentNumber++;
            _controller.text = _currentNumber.toString();
          });
        }
      });
    }
    else{
      _controller.text = totalSteps.toString();
    }

  }
  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      style: const TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
        //filled: true,
        //fillColor: Colors.yellow[100],
      ),
    );
  }
}



