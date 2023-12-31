import 'package:easy_receipt/features/core/adapters/awesome_dialog_adapter.dart';
import 'package:easy_receipt/features/core/ui/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              spacer(20.0),
              _avatar(),
              spacer(20.0),
              _social(context),
              spacer(20.0),
              _name(),
              spacer(20.0),
              _content(),
              spacer(20.0),
              _iconCoffee(context),
              spacer(20.0),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 100.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0)
        )
      ),
      titleTextStyle: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold
      ),
      title: const Text("Sobre o desenvolvedor", maxLines: 2),
      automaticallyImplyLeading: true,
      backgroundColor: Cores.primary,
      elevation: 0,
      leading: IconButton(
        tooltip: "Voltar",
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
  }

  Widget _avatar() {
    return Container(
      width: 150.0,
      height: 150.0,
      padding: const EdgeInsets.all(5.0),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle
      ),
      child: ClipOval(
        child: Image.network(
          "https://avatars.githubusercontent.com/llFurtll",
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
              child: child,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Text(
                "Não foi possível carregar a foto",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            );
          },
        ),
      ),
    );
  }

  IconButton _btnSocial(String url, BuildContext context, IconData icon, Color color) {
    return
      IconButton(
        onPressed: () {
          _launchUrl(url, context);
        },
        icon: FaIcon(icon),
        color: color,
        iconSize: 50.0,
      );
  }

  Widget _social(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: [
        _btnSocial(
          "https://github.com/llFurtll",
          context, FontAwesomeIcons.github,
          Colors.black
        ),
        _btnSocial(
          "https://www.facebook.com/daniel.melonari/",
          context,
          FontAwesomeIcons.facebook,
          const Color(0xFF3b5998)
        ),
        _btnSocial(
          "https://www.linkedin.com/in/daniel-melonari/",
          context,
          FontAwesomeIcons.linkedin,
          const Color(0xFF0e76a8)
        )
      ],
    );
  }

  Widget _name() {
    return const Text(
      "Daniel Melonari",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25.0
      ),
    );
  }

  Widget _content() {
    return const Card(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "Olá, obrigado por usar o EasyReceipt! \n\n"
          "Caso precise de algo, pode entrar em contato comigo por uma das "
          "redes sociais acima, espero que goste, aceitos sugestões.\n\n"
          "Logo abaixo também têm um botão para doações, sempre que possível estarei trazendo "
          "atualizações para o EasyReceipt, visando melhorar sua utilização, se quiser realizar uma doação "
          "independente do valor, ficarei grato.",
          style: TextStyle(
            fontSize: 18.0,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Padding _iconCoffee(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: GestureDetector(
        onTap: () => _launchUrl("https://www.buymeacoffee.com/danielmelonari", context),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("lib/assets/coffee.svg")
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    Uri newUrl = Uri.parse(url);

    Future.value()
      .then((_) async => await launchUrl(newUrl))
      .then((isSucess) => !isSucess ?
        AwesomeDialogAdapter.showDialogMessage(
          context: context,
          type: TypeDialog.error,
          title: "Atenção",
          textMessage: "Não foi possível abrir o link, tente novamente!",
          textButton: "Ok, tentarei de novo!"
        ) :
        null);
  }

  Widget spacer(double height) {
    return SizedBox(
      height: height,
    );
  }
}