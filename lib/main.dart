import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rango_mino/firebase_options.dart';
import 'package:rango_mino/src/controllers/firestore.dart';
import 'package:rango_mino/core/data.dart';
import 'package:rango_mino/src/views/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  TextEditingController  password = TextEditingController();
  TextEditingController  prenom = TextEditingController();
  TextEditingController  nom = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: bodyPage(),
        ),
      )
    );
  }


  Widget bodyPage(){
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
          controller: prenom,
          decoration: const InputDecoration(
              hintText: "Entrer votre prénom"
          ),
        ):Container(),
        const SizedBox(height:10),

        (selection[0]==false)?TextField(
          controller: nom,
          decoration: const InputDecoration(
              hintText: "Entrer votre nom"
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
                FirestoreHelper().inscription(mail.text, password.text, nom.text, prenom.text).then((value) {
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
                  FirestoreHelper().Connect(mail.text, password.text).then((value){
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