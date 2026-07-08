import 'package:flutter/material.dart';
import 'chunky_colors.dart';

class ChunkyCard extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final double borderWidth;
  final double borderRadius;
  final double shadowHeight;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry? alignment;

  const ChunkyCard({
    super.key,
    required this.child,
    this.backgroundColor = ChunkyColors.surfaceContainerHigh,
    this.borderColor = Colors.transparent,
    this.shadowColor = Colors.transparent,
    this.borderWidth = 1.0,
    this.borderRadius = 16.0,
    this.shadowHeight = 0.0,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
    this.alignment,
  });

  @override
  State<ChunkyCard> createState() => _ChunkyCardState();
}

class _ChunkyCardState extends State<ChunkyCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double shadowHeight = widget.onTap != null && _isPressed ? 0.0 : widget.shadowHeight;
    final double topOffset = widget.onTap != null && _isPressed ? widget.shadowHeight : 0.0;

    Widget cardContent = AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      margin: EdgeInsets.only(top: topOffset, bottom: widget.shadowHeight - shadowHeight),
      padding: widget.padding,
      alignment: widget.alignment,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
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
      child: widget.child,
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
