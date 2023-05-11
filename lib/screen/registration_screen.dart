import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const.dart';
import '../utils/route_name.dart';

import '../widgets/FlutterToast.dart';
import '../widgets/textformfiled.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isLoading = false;

  void _submitSignupForm() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection("User_Signup")
            .doc(user.uid)
            .set({
          "name": _name.text.trim(),
          "email": _email.text.trim(),
          "password": _password.text.trim(),
        });
      }
    } on FirebaseAuthException catch (error) {
      flutterToast().toastMessage(error.toString());
    }
    setState(() {
      _isLoading = false;

      flutterToast().toastMessage("Signup Done");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6E6),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Welcome Onboard!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      '  Let’s help you meet your tasks',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFieldExample(
                              hintText: 'Enter your full name',
                              controller: _name,
                              validator: "Name",
                              icon: Icon(Icons.person),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldExample(
                              hintText: 'Enter your email',
                              controller: _email,
                              validator: "Email",
                              icon: Icon(Icons.email_outlined),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldExample(
                                hintText: 'Enter password',
                                controller: _password,
                                validator: "Password",
                                icon: Icon(Icons.password_outlined)),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldExample(
                              hintText: 'Confirm password',
                              controller: _cpassword,
                              validator: "Confirm Password",
                              icon: Icon(Icons.password_rounded),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],

                        )),


                    SizedBox(
                        width: 300 - 50,
                        height: 100 - 50,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(shape: Vx.rounded),
                          child: ElevatedButton(
                            style:
                            ElevatedButton.styleFrom(primary: Color(0xFFF89B76)),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _submitSignupForm();
                              }
                            },
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : const Text(
                              "Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                          ),
                        )),




                    SizedBox(
                      height: 25,
                    ),
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                        child:
                            InkWell(child: Image.asset('assets/google.png'))),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RouteName.login_screen,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              child: Image(
                image: AssetImage(Constants.shape_image),
              ),
            )
          ],
        )),
      ),
    );
  }
}
