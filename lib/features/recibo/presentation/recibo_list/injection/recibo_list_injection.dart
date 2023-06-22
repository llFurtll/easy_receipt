import 'package:screen_manager/screen_injection.dart';

import '../controller/recibo_list_controller.dart';

class ReciboListInjection extends ScreenInjection<ReciboListController> {
  ReciboListInjection({
    super.key,
    super.context,
    super.receiveArgs,
    required super.child,
  }) : super(
    controller: ReciboListController()
  );

  @override
  bool updateShouldNotify(ReciboListInjection oldWidget) => false;
}