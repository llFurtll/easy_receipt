import 'package:flutter/material.dart';
import 'package:screen_manager/screen_injection.dart';

import '../../../../core/injection/global_injection.dart';
import '../../../data/datasources/recibo_local_data_source.dart';
import '../../../data/repositories/recibo_repository_impl.dart';
import '../../../domain/usecases/get_delete.dart';
import '../../../domain/usecases/get_find_recibos.dart';
import '../controller/recibo_list_controller.dart';

class ReciboListInjection extends ScreenInjection<ReciboListController> {
  late final GetFindRecibos getFindRecibos;
  late final GetDeletar getDeletar;

  ReciboListInjection({
    super.key,
    super.context,
    super.receiveArgs,
    required super.child,
  }) : super(
    controller: ReciboListController()
  );

  @override
  void dependencies(BuildContext? context) {
    final repository = ReciboRepositoryImpl(
      ReciboLocalDataSurceImpl(
        GlobalInjection.of(context!).databaseInfo
      )
    );

    getFindRecibos = GetFindRecibos(repository);
    getDeletar = GetDeletar(repository);
  }

  @override
  bool updateShouldNotify(ReciboListInjection oldWidget) => false;
}