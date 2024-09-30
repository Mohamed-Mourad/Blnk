import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final Duration duration = const Duration(milliseconds: 300);

  const PageIndicator({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircle(1),
        _buildLine(1),
        _buildCircle(2),
        _buildLine(2),
        _buildCircle(3),
      ],
    );
  }

  Widget _buildCircle(int page) {
    bool isReached = page <= currentPage;
    return AnimatedContainer(
      duration: duration,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isReached ? Colors.blue : Colors.transparent,
        border: Border.all(
            color: isReached ? Colors.blue : Colors.grey, width: 2.0),
      ),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: duration,
          style: TextStyle(
            color: isReached ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          child: Text('$page'),
        ),
      ),
    );
  }

  Widget _buildLine(int lineIndex) {
    bool isBlue = lineIndex < currentPage;
    return AnimatedContainer(
      duration: duration,
      width: 80,
      height: 2,
      color: isBlue ? Colors.blue : Colors.grey,
    );
  }
}
