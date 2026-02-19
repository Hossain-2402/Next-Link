import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nextlink/feed_screen.dart';
import 'package:smooth_transition/smooth_transition.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

final supabase = Supabase.instance.client;

final String? avaterImage =
    "https://imgs.search.brave.com/uDEcwBKmk2pulTQswWm7XSMR4qrHMDyagzZBYVIMHLs/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dmVjdG9yc3RvY2su/Y29tL2kvNTAwcC8y/OC82Ni9ncmF5LXBy/b2ZpbGUtc2lsaG91/ZXR0ZS1hdmF0YXIt/dmVjdG9yLTIxNTQy/ODY2LmpwZw";

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final TextEditingController _userName = TextEditingController();

  Uint8List? _pickedImage;
  String? _netImage = avaterImage;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_email.text.isEmpty ||
        _password.text.isEmpty ||
        _netImage == avaterImage ||
        _userName.text.isEmpty) {
      return;
    }

    try {
      final response = await supabase.auth.signUp(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      if (response.user != null) {
        try {
          await supabase.from('users').insert({
            'user_name': _userName.text.trim(),
            'user_email': _email.text.trim(),
            'profile_pic_url': _netImage,
          });
        } catch (e) {
          print(e);
        }
        Navigator.push(
          context,
          PageTransition(
            child: FeedScreen(
              userName: _userName.text.trim(),
              profilePic: _netImage,
            ),
            type: PageTransitionType.scaleFade,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
          ),
        );

        _email.clear();
        _password.clear();
      }
    } catch (e) {}
  }

  Future<String> uploadBytes(Uint8List bytes) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    await supabase.storage
        .from('images')
        .uploadBinary(
      fileName,
      bytes,
      fileOptions: const FileOptions(contentType: 'image/jpeg'),
    );

    return supabase.storage.from('images').getPublicUrl(fileName);
  }

  Future<void> _pickImage() async {
    final res = await FilePicker.platform.pickFiles(type: FileType.image);

    if (res == null) return;

    setState(() {
      _pickedImage = res.files.single.bytes;
    });

    if (_pickedImage != null) {
      final url = await uploadBytes(_pickedImage!);
      print('Image URL: $url');
      setState(() {
        _netImage = url;
      });
    }
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
              Color.fromARGB(255, 168, 210, 255),
              // Color.fromARGB(255, 210, 245, 235),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              Center(
                child: Container(
                  height: 150,
                  width: 250,
                  child: Image(image: AssetImage('LOGO.png')),
                ),
              ),
              SizedBox(height: 2.5),
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
              SizedBox(height: 40),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      "https://imgs.search.brave.com/uDEcwBKmk2pulTQswWm7XSMR4qrHMDyagzZBYVIMHLs/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dmVjdG9yc3RvY2su/Y29tL2kvNTAwcC8y/OC82Ni9ncmF5LXBy/b2ZpbGUtc2lsaG91/ZXR0ZS1hdmF0YXIt/dmVjdG9yLTIxNTQy/ODY2LmpwZw",
                    ),
                    foregroundImage: _pickedImage != null
                        ? NetworkImage(_netImage!)
                        : NetworkImage(
                      "https://imgs.search.brave.com/uDEcwBKmk2pulTQswWm7XSMR4qrHMDyagzZBYVIMHLs/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dmVjdG9yc3RvY2su/Y29tL2kvNTAwcC8y/OC82Ni9ncmF5LXBy/b2ZpbGUtc2lsaG91/ZXR0ZS1hdmF0YXIt/dmVjdG9yLTIxNTQy/ODY2LmpwZw",
                    ),
                  ),
                  //const SizedBox(height: 5),
                  Positioned(
                    bottom: -5,
                    right: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: _pickImage,
                        icon: const Icon(Icons.add),
                        iconSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

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
                    controller: _userName,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      focusColor: Colors.black12,
                      labelText: 'Enter User Name',
                      labelStyle: TextStyle(fontSize: 15),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 12.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent, // Change the border color
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
                              .transparent, // Change the focused border color
                          width: 0.0, // Change the focused border width
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

              SizedBox(height: 27),
              ColoredBox(
                color: Colors.grey,
                child: Container(height: 4, width: 50, child: Text("")),
              ),

              SizedBox(height: 27),

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
                              .transparent, // Change the focused border color
                          width: 0.0, // Change the focused border width
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
                              .transparent, // Change the focused border color
                          width: 0.0, // Change the focused border width
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
              SizedBox(height: 70),
              Container(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    _signUp();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Color.fromARGB(255, 168, 210, 255),
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
      ),
    );
  }
}

//
// body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color.fromARGB(255, 168, 210, 255),
//               // Color.fromARGB(255, 210, 245, 235),
//               Color.fromARGB(255, 255, 255, 255),
//               Color.fromARGB(255, 255, 255, 255),
//             ],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//
// 		]
// 	   )
// 	)
//     )
// )
// )