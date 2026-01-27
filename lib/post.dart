import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _postController = TextEditingController();

  void _onPost() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //width: double.infinity,
        //height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 168, 210, 255),
              // Color.fromARGB(255, 210, 245, 235),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255)
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
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 14),

                            CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                "https://imgs.search.brave.com/uDEcwBKmk2pulTQswWm7XSMR4qrHMDyagzZBYVIMHLs/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dmVjdG9yc3RvY2su/Y29tL2kvNTAwcC8y/OC82Ni9ncmF5LXBy/b2ZpbGUtc2lsaG91/ZXR0ZS1hdmF0YXIt/dmVjdG9yLTIxNTQy/ODY2LmpwZw",
                              ),
                            ),

                            const SizedBox(width: 12),

                            const Text(
                              'Tosin',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,

                                shadows: [
                                  //Shadow(
                                  //offset: Offset(1, 1),
                                  //blurRadius: 3,
                                  //color: Colors.purple,
                                  //),
                                  //Shadow(
                                  //offset: Offset(-1, -1),
                                  //blurRadius: 3,
                                  //color: Colors.purple,
                                  //),
                                ],
                              ),
                            ),
                          ],
                        ),

                        //SizedBox(width: 200),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent,
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(-2, -2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Post",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),

                          /*
                          TextButton(
                            onPressed: _onPost,
                            
                            style: TextButton.styleFrom(
                              
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            child: const Text('Post'),
                          ),*/
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _postController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 30,
                        //expands: true,
                        decoration: const InputDecoration(
                          hintText: "Mone ki chole?",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
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

/*
Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _postController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: null,
          expands: true,
          decoration: const InputDecoration(
            hintText: "Mone ki chole?",
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 18),
        ),
      )*/
