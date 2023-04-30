import 'package:flutter/material.dart';
import 'package:rango_mino/core/data.dart';
import 'package:rango_mino/core/style.dart';
import 'package:rango_mino/src/services/auth.dart';
import 'package:rango_mino/src/views/widgets/auth/firstname.dart';
import 'package:rango_mino/src/views/widgets/auth/login.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var loading = false;

  void _handleButtonPress(BuildContext context) async {
    setState(() {
      loading = true;
    });
    if (formKey.currentState!.validate()) {
      bool emailExist = await Auth.isEmailUsed(emailController.text);
      AppData.account.email = emailController.text;
      if (emailExist) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Password(email: emailController.text),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Firstname(email: emailController.text),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("C'est parti"),
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
                  "Email",
                  style: labelStyle,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autofocus: true,
                  controller: emailController,
                  style: inputStyle,
                  decoration: const InputDecoration(
                    hintText: "Quel est votre e-mail",
                  ),
                  validator: (email) {
                    email = email!.trim();
                    if (email != "") {
                      const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                      final regExp = RegExp(pattern);
                      if (!regExp.hasMatch(email)) {
                        return "Le format de l'email est invalide";
                      }
                      return null;
                    }
                    return "Le champ est obligatoire";
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => _handleButtonPress(context),
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