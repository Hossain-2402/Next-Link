import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextlink/sign_up_screen.dart';
import 'package:smooth_transition/smooth_transition.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 500,
                width: 1000,
                child: Image(image: AssetImage('LOGO.png')),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.25,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      // A list of BoxShadows
                      BoxShadow(
                        color: Colors.black12, // Shadow color and opacity
                        spreadRadius: 20, // How much the shadow spreads
                        blurRadius: 15, // How soft the shadow is
                        offset: const Offset(
                          0,
                          10,
                        ), // Offset in x and y direction
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 2,
                                      width: 50,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Welcome Back",
                                      style: GoogleFonts.lobster(
                                        textStyle: TextStyle(
                                          height: 3.5,
                                          color: Colors.black,
                                          fontSize: 35,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Sign In to explore",
                                      style: GoogleFonts.akayaKanadaka(
                                        textStyle: TextStyle(
                                          color: Colors.grey,
                                          height: 1,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 170),
                                    Container(
                                      height: 70,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 5.0,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsGeometry.fromLTRB(
                                          40,
                                          15,
                                          7,
                                          15,
                                        ),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.mail_rounded),
                                            focusColor: Colors.black12,
                                            labelText: 'Enter your email',
                                            labelStyle: TextStyle(fontSize: 15),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 12.0,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors
                                                    .white, // Change the border color
                                                width:
                                                    0.0, // Change the border width
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
                                                width:
                                                    3.0, // Change the focused border width
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
                                      width: 400,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 5.0,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsGeometry.fromLTRB(
                                          40,
                                          10,
                                          7,
                                          10,
                                        ),
                                        child: TextFormField(
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.lock),
                                            focusColor: Colors.black12,
                                            labelText: 'Enter your password',
                                            labelStyle: TextStyle(fontSize: 15),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 12.0,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors
                                                    .white, // Change the border color
                                                width:
                                                    0.0, // Change the border width
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
                                                width:
                                                    3.0, // Change the focused border width
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
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll<Color>(
                                                Color.fromARGB(
                                                  255,
                                                  63,
                                                  229,
                                                  109,
                                                ),
                                              ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsGeometry.all(15),
                                          child: Text(
                                            "Sign In",
                                            style: GoogleFonts.aDLaMDisplay(
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                              ),
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
                                            padding:
                                                EdgeInsetsGeometry.fromLTRB(
                                                  0,
                                                  13,
                                                  0,
                                                  10,
                                                ),
                                            child: Container(
                                              height: 50,
                                              width: 200,
                                              child: Text(
                                                "Don't have an account? ",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: 100,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child: const SignUpScreen(),
                                                    type: PageTransitionType
                                                        .scaleFade,
                                                    duration: const Duration(
                                                      milliseconds: 500,
                                                    ),
                                                    curve: Curves.easeOutBack,
                                                  ),
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                alignment: Alignment.center,
                                              ),
                                              child: Text(
                                                "Sign Up",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
