
import 'package:flutter/material.dart';
import 'dart:async';
void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
));

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      Timer(Duration(seconds: 3), () =>
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyRoutes2())));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("imagens/logo.png")
                    ]
                  ),
                ),
              ),
              Expanded(flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                      padding: EdgeInsets.only(top: 20)),
                  Text("Por favor \n Aguarde", style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                ],
              ),)
            ],
          )
        ],
      ),
    );
  }
}


class MyRoutes2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
      },
      // Criando uma fun????o para operar com rotas nomeadas.
      // Usamos esta fun????o para identificar o nome da
      // rota que tem push, e criar a rota para a
      // tela correta.
      onGenerateRoute: (settings) {
        // Se voc?? der push passamos argumentos pela rota
        if (settings.name == PassArgumentsScreen.routeName) {
          // envie os argumentos para a rota correta
          // digite: ScreenArguments.
          final args = settings.arguments as ScreenArguments;

          // Em seguida, extraia os dados necess??rios dos
          // os argumentos e passar os dados para a
          // tela correta.
          // configura????o da estiliza????o da tela
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
        // O c??digo suporta apenas
        // PassArgumentsScreen.routeName a partir de agora.
        // Outros valores precisam ser implementados se precisarmos

        assert(false, 'Precisa implemetar ${settings.name}');
        return null;
      },
      title: 'Navega????o com argumentos',
      home: HomeScreen(),
    );
  }
}




class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotas Nomeadas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ??????bot??o que navega para uma rota nomeada.
            // A rota nomeada extrai os argumentos
            // sozinha.
            ElevatedButton(
              onPressed: () {
                // O que acontece:
                // Quando o usu??rio toca no bot??o,
                // navega para uma rota nomeada e
                // fornece os argumentos como um opcional de
                // par??metro.
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Argumentos',
                    'Esta mensagem ?? extra??da no m??todo de constru????o. ?? a extra????o dos argumentos passados no m??todo',
                  ),
                );
              },
              child: Text('Clique para enviar dados'),
            ),
            // O ??????bot??o que navega para uma rota nomeada.
            // Para esta rota, extraia os argumentos em
            // a fun????o onGenerateRoute e envia
            // para a tela definida.
            Padding(padding: EdgeInsets.all(8)),
            ElevatedButton(
              onPressed: () {
                // Quando o usu??rio toca no bot??o,
                // navega para uma rota nomeada e
                // fornece os argumentos como um opcional de
                // par??metro.
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Recebendo do Route',
                    'Esta mensagem ?? extra??da na fun????o onGenerateRoute.',
                  ),
                );
              },
              child: Text('Navegue at?? uma rota que aceita argumentos'),
            ),
          ],
        ),
      ),
    );
  }
}

// Este ??????widget que extrai os argumentos necess??rios de
// o ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extrai os argumentos do ModalRoute atual
    // configura e e envia como ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

// W???widget aceita os argumentos necess??rios por meio do
// construtor
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // Este widget aceita os argumentos como construtor de
  // par??metros, por??m n??o extrai os argumentos de
  // o ModalRoute.
  // ----------------------------------
  // Os argumentos s??o extra??dos pela fun????o onGenerateRoute
  // declarada no widget MaterialApp.
  const PassArgumentsScreen({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

// Podemos passar qualquer objeto para o par??metro de argumentos.
// Neste exemplo, criamos uma classe que com t??tulo e uma
// mensagem
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}