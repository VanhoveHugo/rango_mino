import 'package:flutter/material.dart';
import 'package:rango_mino/src/views/widgets/auth/email.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Align(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                googleButton(),
                const SizedBox(height: 10),
                facebookButton(),
                const SizedBox(height: 10),
                emailButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget googleButton() {
    return TextButton(
      onPressed: () => '',
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.black),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
        ),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.facebook,
            color: Colors.white,
          ),
          SizedBox(width: 10, height: 25),
          Text(
            "Connexion avec Google",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15
            ),
          )
        ],
      ),
    );
  }

  Widget facebookButton() {
    return TextButton(
      onPressed: () => '',
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.blue),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
        ),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.facebook,
            color: Colors.white,
          ),
          SizedBox(width: 10, height: 25),
          Text(
            "Connexion avec Facebook",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15
            ),
          )
        ],
      ),
    );
  }


  Widget emailButton() {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Email(),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.brown),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
        ),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(width: 0, height: 25),
          Text(
            "Connexion avec l'email",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15
            ),
          )
        ],
      ),
    );
  }
}


//              Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   const Text(
//                     "Rango Mino",
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: const InputDecoration(
//                       labelText: "Email",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Email is required";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: "Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Password is required";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         _login();
//                       }
//                     },
//                     child: const Text("Login"),
//                   ),
//                   const SizedBox(height: 16),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Text("Register"),
//                         ),
//                       );
//                     },
//                     child: const Text("Register"),
//                   ),
//                 ],
//               ),
//             ),
        