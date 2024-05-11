import 'package:flutter/material.dart';

import 'tickets_manager.dart';
import 'tickets_manager_provider.dart';

extension TicketsNotifierExt on BuildContext {
  TicketsManager get getManager => TicketsManagerProvider.of(this);
}
