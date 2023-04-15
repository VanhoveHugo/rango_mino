import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rango_mino/src/controllers/firestore.dart';
import 'package:rango_mino/core/data.dart';
import 'package:rango_mino/src/models/consumers.dart';

class ListPersonn extends StatefulWidget {
  const ListPersonn({Key? key}) : super(key: key);

  @override
  State<ListPersonn> createState() => _ListPersonnState();
}

class _ListPersonnState extends State<ListPersonn> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().cloudUsers.snapshots(),
        builder: (context,snap){
        List documents = snap.data?.docs ?? [];
        if(documents.isEmpty){
          return const Center(
              child: CircularProgressIndicator.adaptive()
          );
        } else
          {
            return ListView.builder(
              itemCount: documents.length,
                itemBuilder: (context,index) {
                  Consumer otherUser = Consumer(documents[index]);
                  if (AppData.account.id == otherUser.id) {
                    return Container();
                  }
                  else {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: (){
                          //ouvrir une nouvller page de chat
                          print("message");
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(otherUser.picture!),
                        ),
                        title: Text(otherUser.username),
                        subtitle: Text(otherUser.email),
                      ),
                    );
                  }
                }
            );
          }

        }
    );
  }
}
