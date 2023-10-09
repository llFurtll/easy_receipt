import 'package:easy_receipt/features/core/database/database.dart';
import 'package:flutter/material.dart';

class GlobalInjection extends InheritedWidget {
  final databaseInfo = DatabaseInfoImpl();

  GlobalInjection({
    super.key,
    required super.child
  });

  static GlobalInjection of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<GlobalInjection>();
    assert(result != null, "No injection found on context");
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false; 
}