import 'package:flutter/material.dart';

import 'tickets_manager.dart';

class TicketsManagerProvider extends InheritedWidget {
  const TicketsManagerProvider({
    super.key,
    required this.manager,
    required super.child,
  });

  final TicketsManager manager;

  static TicketsManager of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TicketsManagerProvider>()!
        .manager;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
