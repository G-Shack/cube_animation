import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Padding(padding: EdgeInsets.all(32.0), child: SquareAnimation()),
    );
  }
}

/// A widget that animates a square moving left and right.
class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() => SquareAnimationState();
}

/// The state class for [SquareAnimation].
class SquareAnimationState extends State<SquareAnimation> {
  static const _squareSize = 50.0;
  static const _animationDuration = Duration(seconds: 1);

  Alignment _alignment = Alignment.center;
  bool _isAnimating = false;

  /// Moves the square to the right edge.
  void _moveRight() {
    setState(() {
      _alignment = Alignment.centerRight;
      _isAnimating = true;
    });
  }

  /// Moves the square to the left edge.
  void _moveLeft() {
    setState(() {
      _alignment = Alignment.centerLeft;
      _isAnimating = true;
    });
  }

  /// Returns `true` if the square is at the left edge.
  bool get _isAtLeft => _alignment == Alignment.centerLeft;

  /// Returns `true` if the square is at the right edge.
  bool get _isAtRight => _alignment == Alignment.centerRight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. The square starts in the center of the screen.
        // 2. "To Right" moves the square to the right edge of the screen.
        // 3. "To Left" moves the square to the left edge of the screen.
        // 6. Animate the movement with a 1-second duration.
        // 7. Disable both buttons during movement.
        Expanded(
          child: AnimatedAlign(
            alignment: _alignment,
            duration: _animationDuration,
            onEnd: () {
              setState(() {
                _isAnimating = false;
              });
            },
            child: Container(
              width: _squareSize,
              height: _squareSize,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // 4. Disable "To Right" when the square is at the right edge.
        // 5. Disable "To Left" when the square is at the left edge.
        Row(
          children: [
            IgnorePointer(
              ignoring: _isAtLeft || _isAnimating,
              child: Opacity(
                opacity: (_isAtLeft || _isAnimating) ? 0.5 : 1.0,
                child: ElevatedButton(
                  onPressed: _moveLeft,
                  child: const Text('Left'),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IgnorePointer(
              ignoring: _isAtRight || _isAnimating,
              child: Opacity(
                opacity: (_isAtRight || _isAnimating) ? 0.5 : 1.0,
                child: ElevatedButton(
                  onPressed: _moveRight,
                  child: const Text('Right'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
