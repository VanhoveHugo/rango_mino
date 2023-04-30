import 'package:flutter/material.dart';
import 'package:rango_mino/core/data.dart';
import 'package:rango_mino/core/style.dart';
import 'package:rango_mino/src/services/auth.dart';
import 'package:rango_mino/src/models/consumers.dart';
import 'package:rango_mino/src/views/dashboard.dart';

class Register extends StatefulWidget {
  final String email;
  final String firstname;
  final String username;
  const Register({Key? key, required this.email, required this.firstname, required this.username}) : super(key: key);

  @override
  State<Register> createState() => _UsernameState();
}

class _UsernameState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  bool loading = false;

  void _handleButtonPress(BuildContext context, String email, String firstname, String username) async {
    setState(() {
      loading = true;
    });
    if (formKey.currentState!.validate()) {
      Consumer user = await Auth.register(email, passwordController.text, firstname, username);
      if (user.email != "") {
        AppData.account = user;
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashBoardView(mail: user.email),
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
    String username = widget.username;
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
                  "Mot de passe",
                  style: labelStyle,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autofocus: true,
                  obscureText: true,
                  controller: passwordController,
                  style: inputStyle,
                  decoration: const InputDecoration(
                    hintText: "Quel est votre mot de passe",
                  ),
                  validator: (password) {
                    password = password!.trim();
                    if (password != "") {
                      if (password.length < 5) {
                        return "Le mot de passe ou l'email est incorrect 1";
                      }
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
                    onPressed: () => _handleButtonPress(context, email, firstname, username),
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