import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nextlink/feed_screen.dart';
import 'package:smooth_transition/smooth_transition.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

final supabase = Supabase.instance.client;

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      return;
    }

    try {
      final response = await supabase.auth.signUp(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      if (response.user != null) {
        _email.clear();
        _password.clear();
        Navigator.push(
          context,
          PageTransition(
            child: const FeedScreen(),
            type: PageTransitionType.scaleFade,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
          ),
        );
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 168, 247, 238),
              // Color.fromARGB(255, 210, 245, 235),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: Container(
                        height: 200,
                        width: 400,
                        child: Image(image: AssetImage('LOGO.png')),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Register",
                      style: GoogleFonts.lobster(
                        textStyle: TextStyle(
                          height: 3.5,
                          color: Colors.black,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Text(
                      "Sign Up to explore",
                      style: GoogleFonts.akayaKanadaka(
                        textStyle: TextStyle(
                          color: Colors.grey,
                          height: 1,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Container(
                      height: 70,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 5.0),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(40, 15, 7, 15),
                        child: TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.mail_rounded),
                            focusColor: Colors.black12,
                            labelText: 'Enter your email',
                            labelStyle: TextStyle(fontSize: 15),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 12.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white, // Change the border color
                                width: 0.0, // Change the border width
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  40.0,
                                ), // Applies a 20px radius to all four corners
                              ), // Optional: add border radius
                            ),
                            // Focused border style
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white, // Change the focused border color
                                width: 3.0, // Change the focused border width
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  40.0,
                                ), // Applies a 20px radius to all four corners
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 25),
                    Container(
                      height: 70,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 5.0),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(40, 10, 7, 10),
                        child: TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            focusColor: Colors.black12,
                            labelText: 'Enter your password',
                            labelStyle: TextStyle(fontSize: 15),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 12.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white, // Change the border color
                                width: 0.0, // Change the border width
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  40.0,
                                ), // Applies a 20px radius to all four corners
                              ), // Optional: add border radius
                            ),
                            // Focused border style
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white, // Change the focused border color
                                width: 3.0, // Change the focused border width
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  40.0,
                                ), // Applies a 20px radius to all four corners
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    Container(
                      height: 50,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () {
                          _signUp();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            Color.fromARGB(255, 63, 229, 109),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(15),
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.aDLaMDisplay(
                              textStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: 300,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.fromLTRB(0, 15, 0, 10),
                            child: Container(
                              height: 50,
                              width: 200,
                              child: Text(
                                "Already have an account? ",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                              ),
                              child: Text(
                                "Sign in",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
