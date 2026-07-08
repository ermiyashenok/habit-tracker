import 'package:flutter/material.dart';
import 'chunky_colors.dart';

class ChunkyButton extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final double borderRadius;
  final double shadowHeight;
  final double height;
  final VoidCallback? onTap;

  const ChunkyButton({
    super.key,
    required this.child,
    this.backgroundColor = ChunkyColors.primary,
    this.borderColor = Colors.transparent,
    this.shadowColor = Colors.transparent,
    this.borderRadius = 16.0,
    this.shadowHeight = 0.0,
    this.height = 56.0,
    required this.onTap,
  });

  @override
  State<ChunkyButton> createState() => _ChunkyButtonState();
}

class _ChunkyButtonState extends State<ChunkyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double shadowHeight = widget.onTap != null && _isPressed ? 0.0 : widget.shadowHeight;
    final double topOffset = widget.onTap != null && _isPressed ? widget.shadowHeight : 0.0;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        height: widget.height,
        margin: EdgeInsets.only(top: topOffset, bottom: widget.shadowHeight - shadowHeight),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: widget.borderColor,
            width: widget.borderColor == Colors.transparent ? 0 : 2.0,
          ),
          boxShadow: shadowHeight > 0
              ? [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: Offset(0, shadowHeight),
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}
