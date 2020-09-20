import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../home_page.dart';



class ScreenFirst extends StatefulWidget {
  @override
  _ScreenFirstState createState() => _ScreenFirstState();
}

class _ScreenFirstState extends State<ScreenFirst>  {
final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('resource/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Utilize para adicionar algo",
          body:
              "Você pode utilizar sempre que precisar adicionar alguma informação",
          image: _buildImage('mais'),
          decoration: pageDecoration,
        ),
                PageViewModel(
          title: "Deslize para mais opções",
          body:
              "Você pode deslizar seu dedo nas escola, turmas, alunos, criterios e observações para editar ou excluir informações",
          image: _buildImage('deslizar'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Pular instrução'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Entendi', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

}