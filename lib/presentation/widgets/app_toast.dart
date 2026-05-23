import 'dart:async';

import 'package:flutter/material.dart';

/// Brief icon-only reaction bubble that confirms an action without using a
/// snackbar or covering the add-property FAB.
class AppToast {
  static OverlayEntry? _current;
  static Timer? _timer;

  /// The [message] parameter is accepted for call-site compatibility but is
  /// not rendered — feedback is now purely visual.
  static void show(
    BuildContext context, {
    String? message,
    required IconData icon,
    required Color accentColor,
    Duration duration = const Duration(milliseconds: 1100),
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);
    _current?.remove();
    _timer?.cancel();

    final entry = OverlayEntry(
      builder: (_) => _BurstView(
        icon: icon,
        accentColor: accentColor,
        duration: duration,
      ),
    );

    _current = entry;
    overlay.insert(entry);

    _timer = Timer(duration, () {
      _current?.remove();
      _current = null;
      _timer = null;
    });
  }
}

class _BurstView extends StatefulWidget {
  const _BurstView({
    required this.icon,
    required this.accentColor,
    required this.duration,
  });

  final IconData icon;
  final Color accentColor;
  final Duration duration;

  @override
  State<_BurstView> createState() => _BurstViewState();
}

class _BurstViewState extends State<_BurstView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..forward();

  late final Animation<double> _bubbleScale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(begin: 0.0, end: 1.12).chain(CurveTween(curve: Curves.easeOutBack)),
      weight: 45,
    ),
    TweenSequenceItem(
      tween: Tween(begin: 1.12, end: 1.0).chain(CurveTween(curve: Curves.easeOutCubic)),
      weight: 20,
    ),
    TweenSequenceItem(tween: ConstantTween(1.0), weight: 35),
  ]).animate(_controller);

  late final Animation<double> _fade = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween(1.0), weight: 72),
    TweenSequenceItem(
      tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeInCubic)),
      weight: 28,
    ),
  ]).animate(_controller);

  late final Animation<Offset> _slide = TweenSequence<Offset>([
    TweenSequenceItem(
      tween: Tween(
        begin: const Offset(0, 0.25),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic)),
      weight: 55,
    ),
    TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 45),
  ]).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Positioned(
      left: 0,
      right: 0,
      bottom: bottomInset + 28,
      child: IgnorePointer(
        child: SlideTransition(
          position: _slide,
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _bubbleScale,
              child: Center(
                child: SizedBox(
                  width: 84,
                  height: 84,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _ReactionRing(color: accentColor),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              accentColor.withValues(alpha: 0.95),
                              accentColor.withValues(alpha: 0.7),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.32),
                              blurRadius: 22,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color get accentColor => widget.accentColor;
}

class _ReactionRing extends StatelessWidget {
  const _ReactionRing({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78,
      height: 78,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withValues(alpha: 0.22),
          width: 8,
        ),
      ),
    );
  }
}
