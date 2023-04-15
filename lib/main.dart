import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rango_mino/firebase_options.dart';
import 'package:rango_mino/core/data.dart';
import 'package:rango_mino/src/models/consumers.dart';
import 'package:rango_mino/src/views/dashboard.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rango&Mino',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstname = TextEditingController();
  List<bool> selection = [true,false];

  popUp(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          if (defaultTargetPlatform == TargetPlatform.iOS){
            return CupertinoAlertDialog(
              title: const Text("Erreur"),
              content: const Text("Votre email et/ou votre mot de passe sont incorrectes"),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("ok")
                )
              ],
            );
          }
          else
            {
              return AlertDialog(
                title: const Text("Erreur"),
                content: const Text("Votre email et/ou votre mot de passe sont incorrectes"),
                actions: [
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("ok")
                  )
                ],
              );
            }
        }
    );
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: customScaffold(),
        ),
      )
    );
  }


  Widget customScaffold(){
     return Column(
      children: [
        ToggleButtons(
          onPressed: (int choix){
            if(choix == 0) {
              setState(() {
                selection[0]=true;
                selection[1]= false;
              });
            } else {
              setState(() {
                selection[0]=false;
                selection[1]= true;
              });
            }
          },
            isSelected: selection,
            children: const [
              Text("Connexion"),
              Text("Inscription")
            ]
        ),
        const SizedBox(height:10),

        (selection[0] == false)?TextField(
          controller: username,
          decoration: const InputDecoration(
              hintText: "Entrer votre nom d'utilisateur"
          ),
        ):Container(),
        const SizedBox(height:10),

        (selection[0]==false)?TextField(
          controller: firstname,
          decoration: const InputDecoration(
              hintText: "Entrer votre prenom"
          ),
        ):Container(),
        const SizedBox(height:10),

        TextField(
          controller: mail,
          decoration: const InputDecoration(
            hintText: "Entrer votre mail"
          ),
        ),
        const SizedBox(height:10),

        TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Entrer votre password"
          ),
        ),
        const SizedBox(height:10),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder()
          ),
            onPressed: (){
              if(selection[0]== false){
                Consumer.register(mail.text, password.text, firstname.text, username.text).then((value) {
                  setState(() {
                    AppData.account = value;
                  });
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return DashBoardView(mail: mail.text, password: password.text);
                      }
                  ));
                }).catchError((onError){
                  popUp();
                });
              }
              else
                {
                  Consumer.login(mail.text, password.text).then((value){
                    setState(() {
                      AppData.account = value;
                    });
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return DashBoardView(mail: mail.text, password: password.text);
                        }
                    ));
                  }).catchError((onError){
                    popUp();
                  });
                }
            },
            child: const Text("Validation")
        )
      ],
    );
  }
}