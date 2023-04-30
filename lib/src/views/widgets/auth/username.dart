import 'package:flutter/material.dart';
import 'package:rango_mino/core/style.dart';
import 'package:rango_mino/src/services/auth.dart';
import 'package:rango_mino/src/models/consumers.dart';
import 'package:rango_mino/src/views/widgets/auth/register.dart';

class Username extends StatefulWidget {
  final String email;
  final String firstname;
  const Username({Key? key, required this.email, required this.firstname}) : super(key: key);

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  bool loading = false;

  void _handleButtonPress(BuildContext context, String email, String firstname) async {
    setState(() {
      loading = true;
    });
    if (formKey.currentState!.validate()) {
      // Consumer user = await Auth.register(email, usernameController.text);
      if (usernameController.text != "") {
         // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Register(email: email, firstname: firstname, username: usernameController.text),
          ),
        );
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    String firstname = widget.firstname;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
      ),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (loading) ? const SizedBox(height: 5, child: LinearProgressIndicator()) : const SizedBox(height: 5),
                const Text(
                  "Nom d'utilisateur",
                  style: labelStyle,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autofocus: true,
                  controller: usernameController,
                  style: inputStyle,
                  decoration: const InputDecoration(
                    hintText: "Chosissez un nom d'utilisateur",
                  ),
                  validator: (username) {
                    username = username!.trim();
                    if (username != "") {
                      return null;
                    } else {
                      return "Le champ est obligatoire";
                    }
                    
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => _handleButtonPress(context, email, firstname),
                    style: buttonPrimary,
                    child: const Text(
                      "Continuer",
                      style: textButtonPrimary                      
                    ),
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}