import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LloginPageState();
}

class LloginPageState extends State<LoginPage> {
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Spacer(),
              Container(
                width: 100,
                height: 100,
                child: Lottie.asset("assets/loginAnim.json"),
                // child: Lottie.network(
                //     "https://assets8.lottiefiles.com/private_files/lf30_iraugwwv.json"),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value == "") {
                      return "El email es obligatorio";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _controllerPassword,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value == "" || value!.length < 6) {
                      return "El password debe tener 6 caracteres como mínimo";
                    }
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                //GESTURE DETECTOR ON MOBILE
                onTap: () {
                  final isValid = _formKey.currentState!.validate();

                  if (isValid) {
                    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

                    // _firebaseAuth
                    //     .createUserWithEmailAndPassword(
                    //         email: _controllerEmail.text,
                    //         password: _controllerPassword.text)
                    //     .then((value) {
                    //   print(value.user!.uid);
                    //   _controllerEmail.text = "";
                    //   _controllerPassword.text = "";
                    // });

                    _firebaseAuth
                        .signInWithEmailAndPassword(
                            email: _controllerEmail.text,
                            password: _controllerPassword.text)
                        .then((value) {
                      print(value.user!.uid);
                      _controllerEmail.text = "";
                      _controllerPassword.text = "";
                    }).catchError((error, stackTrace) {
                      print(error.toString());
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())));
                    });
                  }
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Center(
                      child: Text(
                    "Ingresar",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
