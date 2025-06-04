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
  final int targetNumber;
  final Duration duration;
  final TextEditingController controller;
  final TextStyle? style;
  final InputDecoration? decoration;

  const AnimatedTextFieldCounter({
    super.key,
    required this.targetNumber,
    required this.controller,
    this.duration = const Duration(seconds: 2),
    this.style,
    this.decoration,
  });

  @override
  State<AnimatedTextFieldCounter> createState() =>
      _AnimatedTextFieldCounterState();
}
class _AnimatedTextFieldCounterState extends State<AnimatedTextFieldCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _initAnimation();
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = IntTween(
      begin: 0,
      end: widget.targetNumber,
    ).animate(_animationController)
      ..addListener(() {
        widget.controller.text = _animation.value.toString();
      });

    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedTextFieldCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.targetNumber != widget.targetNumber) {
      _animationController.dispose();
      _initAnimation(); // chạy lại animation nếu target đổi
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: widget.style ?? const TextStyle(fontSize: 20),
      decoration: widget.decoration ?? const InputDecoration(border: OutlineInputBorder()),
      readOnly: true,
    );
  }
}


class AnimatedCountingTextField extends StatefulWidget {
  final TextEditingController controller;
  final String target;
  final String label;
  final Duration duration;
  final bool readOnly;
  const AnimatedCountingTextField({
    super.key,
    required this.controller,
    required this.target,
    this.label = '',
    this.duration = const Duration(seconds: 1),
    this.readOnly = false,
  });

  @override
  State<AnimatedCountingTextField> createState() =>
      _AnimatedCountingTextFieldState();
}

class _AnimatedCountingTextFieldState extends State<AnimatedCountingTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
      _initAnimation();
  }

  void _initAnimation() {
    final rawText = int.tryParse(widget.target);
      _animationController = AnimationController(
        vsync: this,
        duration: widget.duration,
      );
    widget.controller.text = '0';
      _animation = IntTween(
        begin: 0,
        end: rawText,
      ).animate(_animationController)
        ..addListener(() {
          widget.controller.text = _animation.value.toString();
        });
      _animationController.forward();

  }
  @override
  void didUpdateWidget(covariant AnimatedCountingTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller.text != widget.controller.text) {
        _animationController.dispose();
        _initAnimation(); // chạy lại animation nếu target đổi

    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: widget.readOnly,
      style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
        //filled: true,
        //fillColor: Colors.yellow[100],
      ),


      //decoration: widget.decoration ?? const InputDecoration(border: OutlineInputBorder()),
    );
  }
}




// class AnimatedTextFieldCounter extends StatefulWidget {
//   final String label;
//   final String targetNumber;
//   final Duration duration;
//
//   const AnimatedTextFieldCounter({
//     super.key,
//     required this.label,
//     required this.targetNumber,
//     this.duration = const Duration(seconds: 1),
//   });
//
//   @override
//   State<AnimatedTextFieldCounter> createState() => _AnimatedTextFieldCounterState();
// }
//
// class _AnimatedTextFieldCounterState extends State<AnimatedTextFieldCounter> {
//   final TextEditingController _controller = TextEditingController();
//   Timer? _timer;
//   int _currentNumber = 0;
//   @override
//   void initState() {
//     super.initState();
//     _startCounting();
//   }
//
//   void _startCounting() {
//     int totalSteps = 0;
//     if( widget.targetNumber != '' && widget.targetNumber.isNotEmpty)
//       totalSteps = int.parse(widget.targetNumber);
//     if(totalSteps > 0) {
//       int millisecondsPerStep = (widget.duration.inMilliseconds / totalSteps).round();
//       _timer = Timer.periodic(Duration(milliseconds: millisecondsPerStep), (timer) {
//         if (_currentNumber >= totalSteps) {
//           _timer?.cancel();
//         } else {
//           setState(() {
//             _currentNumber = _currentNumber + 5;
//             _controller.text = _currentNumber.toString();
//           });
//         }
//       });
//     }
//     else{
//       _controller.text = totalSteps.toString();
//     }
//
//   }
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: _controller,
//       readOnly: true,
//       style: const TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
//       decoration: InputDecoration(
//         labelText: widget.label,
//         border: OutlineInputBorder(),
//         //filled: true,
//         //fillColor: Colors.yellow[100],
//       ),
//     );
//   }
// }






