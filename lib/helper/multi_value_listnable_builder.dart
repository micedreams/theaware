import 'package:flutter/widgets.dart';

/// A signature of a function that builds a [Widget], used in [MultiValueListenableBuilder].
typedef MultiValueWidgetBuilder = Widget Function(
    BuildContext context, Widget? child);

/// A widget similar to [ValueListenableBuilder] but with the added ability to listen to
/// a list of [Listenable]s.
class MultiValueListenableBuilder extends AnimatedBuilder {
  /// Constructor.
  MultiValueListenableBuilder({
    required List<Listenable> valueListenables,
    required super.builder,
    super.child,
    super.key,
  }) : super(
          animation: Listenable.merge(valueListenables),
        );
}
