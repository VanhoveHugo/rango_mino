import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rango_mino/src/controllers/firestore.dart';
import 'package:rango_mino/src/views/liste_personnes.dart';
import 'package:rango_mino/core/data.dart';

class DashBoardView extends StatefulWidget {
  String mail;
  String password;
  DashBoardView({Key? key,required this.mail,required this.password}) : super(key: key);

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int indexCurrent = 1;
  PageController controllerPage = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width *0.5,
        height : MediaQuery.of(context).size.height,
        color: Colors.white,
        child : MyDrawer()
      ),
      appBar: AppBar(
        title: Text(AppData.account.firstname),
      ),
      body : bodyPage(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexCurrent,
        onTap: (value){
          setState((){
            indexCurrent = value;
            controllerPage.jumpToPage(value);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
            label: "Personnes"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_outlined),
            label: "Favoris"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.back_hand),
              label: "Nouveau"
          ),
        ],
      ),
    );
  }

  Widget bodyPage(){
    return PageView(
      controller: controllerPage,
      onPageChanged: (value){
        setState(() {
          controllerPage.jumpToPage(value);
          indexCurrent = value;
        });
      },
      children: const [
        ListPersonn(),
        Text("Deuxième page"),
        Text("Troisème page"),
      ],
    );
  }
}

class MyDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyDrawerState();
  }
}

class MyDrawerState extends State<MyDrawer>{
  String? nameImage;
  String? urlImage;
  Uint8List? dataImage;

  popUpChoix(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Votre image"),
            content: Image.memory(dataImage!),
            actions: [
              TextButton(onPressed: ()=> Navigator.pop(context), child: const Text("Annuler")),
              TextButton(onPressed: (){
                FirestoreHelper().stockageImage(dossier: "AVATARS", dossierPersonnel: AppData.account.id, nameImage: nameImage!, bytesImage: dataImage!).then((urlBaseDeDonne) {
                  urlImage = urlBaseDeDonne;
                  //récupérer l'url
                  Map<String,dynamic> data = {
                    "AVATAR": urlImage
                  };
                  setState(() {
                    AppData.account.picture = urlImage;
                  });
                  //mettre à jour les infos utilisateurs
                  FirestoreHelper().updateUser(AppData.account.id, data);
                  //fermer le nouveau pop
                  Navigator.pop(context);
                });
                },
                  child: const Text("Upload")
              )
            ],
          );
        }
    );
  }

  popImage() async {
    FilePickerResult? resultat = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image
    );
    if(resultat != null){
      nameImage = resultat.files.first.name;
      dataImage = resultat.files.first.bytes;
      popUpChoix();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
      child: Column(
        children : [
          InkWell(
            onTap: (){
              popImage();
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(AppData.account.picture!),
            ),
          ),

          Text(AppData.account.username),
          Text(AppData.account.firstname),
          Text(AppData.account.email)
        ]
      ),
    );
  }

}