import 'package:flutter/material.dart';
import 'package:screen_manager/screen_view.dart';

import '../../../../core/ui/cores.dart';
import '../controller/recibo_list_controller.dart';
import '../injection/recibo_list_injection.dart';

class ReciboListScreen extends Screen {
  const ReciboListScreen({super.key});

  @override
  ReciboListInjection build(BuildContext context) {
    return ReciboListInjection(
      child: const ScreenBridge<ReciboListController, ReciboListInjection>(
        child: ReciboListView(),
      )
    );
  }
}

class ReciboListView extends ScreenView<ReciboListController> {
  const ReciboListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.scaffold,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFab(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 10.0,
      backgroundColor: Cores.appBar,
      toolbarHeight: 130.0,
      title: const Text(
        "Recibos",
        style: TextStyle(
          color: Colors.white
        ),
      ),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35.0
      ),
      flexibleSpace: const Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: Icon(
            Icons.receipt_long_outlined,
            size: 120.0,
            color: Colors.white,
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0)
        )
      ),
    );
  }

  Widget _buildBody() {
    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, value, child) {
        if (value) return const Center(child: CircularProgressIndicator());

        final lista = controller.recibos;
        final sizeList = lista.length;

        if (sizeList == 0) {
          return const Center(
            child: Text(
              "Você não possuí nenhum recibo!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Cores.text,
                fontSize: 35.0
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          );
        }

        return ListView.separated(
          itemBuilder: (context, index) => Text("$index"),
          separatorBuilder: (context, index) => const SizedBox(height: 15.0,),
          itemCount: sizeList
        );
      },
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: Cores.fab,
      onPressed: controller.newRecibo,
      child: const Icon(Icons.add),
    );
  }
}