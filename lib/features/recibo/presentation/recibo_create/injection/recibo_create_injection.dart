import 'package:screen_manager/screen_injection.dart';

import '../controller/recibo_create_controller.dart';

class ReciboCreateInjection extends ScreenInjection<ReciboCreateController> {
  ReciboCreateInjection({
    super.key,
    super.context,
    required super.child,
  }) : super(
    controller: ReciboCreateController()
  );

  @override
  bool updateShouldNotify(ReciboCreateInjection oldWidget) => false;
}