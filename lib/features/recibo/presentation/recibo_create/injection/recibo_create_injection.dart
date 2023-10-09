import 'package:flutter/material.dart';
import 'package:screen_manager/screen_injection.dart';

import '../../../../core/injection/global_injection.dart';
import '../../../data/datasources/recibo_local_data_source.dart';
import '../../../data/repositories/recibo_repository_impl.dart';
import '../../../domain/usecases/get_insert_recibo.dart';
import '../controller/recibo_create_controller.dart';

class ReciboCreateInjection extends ScreenInjection<ReciboCreateController> {
  late final GetInsertRecibo getInsertRecibo;

  ReciboCreateInjection({
    super.key,
    super.context,
    required super.child,
  }) : super(
    controller: ReciboCreateController()
  );

  @override
  bool updateShouldNotify(ReciboCreateInjection oldWidget) => false;

  @override
  void dependencies(BuildContext? context) {
    getInsertRecibo = GetInsertRecibo(
      ReciboRepositoryImpl(
        ReciboLocalDataSurceImpl(
          GlobalInjection.of(context!).databaseInfo
        )
      )
    );
  }
}