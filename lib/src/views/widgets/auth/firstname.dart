import 'package:flutter/material.dart';
import 'package:rango_mino/core/style.dart';
import 'package:rango_mino/src/views/widgets/auth/username.dart';

class Firstname extends StatefulWidget {
  final String email;
  const Firstname({Key? key, required this.email}) : super(key: key);

  @override
  State<Firstname> createState() => _FirstnameState();
}

class _FirstnameState extends State<Firstname> {
  final formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  bool loading = false;

  void _handleButtonPress(BuildContext context, String email) async {
    setState(() {
      loading = true;
    });
    if (formKey.currentState!.validate()) {
      if (firstnameController.text != "") {
         // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Username(email: email, firstname: firstnameController.text),
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
                  "Prénom",
                  style: labelStyle,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autofocus: true,
                  controller: firstnameController,
                  style: inputStyle,
                  decoration: const InputDecoration(
                    hintText: "Quel est votre prénom",
                  ),
                  validator: (firstname) {
                    firstname = firstname!.trim();
                    if (firstname != "") {
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
                    onPressed: () => _handleButtonPress(context, email),
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