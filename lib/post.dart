import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart'; // This helps us use "Uint8List" datatype

class PostScreen extends StatefulWidget {
  final String? userName;
  final String? profilePic;

  const PostScreen({
    required this.userName,
    required this.profilePic,
    super.key,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

final supabase = Supabase.instance.client;

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _postController = TextEditingController();
  Uint8List? _pickedImage;
  String? _imageFromGallary;

  void _pickImage() async {
    var response = await FilePicker.platform.pickFiles(type: FileType.image);

    if (response == null) {
      // SHOW SNAKBAR SAYING : Invalid Image
      return;
    }

    setState(() {
      _pickedImage = response.files.single.bytes;
    });
    if (_pickedImage != null) {
      final String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";

      await supabase.storage
          .from('images')
          .uploadBinary(
            fileName,
            _pickedImage!,
            fileOptions: FileOptions(contentType: 'image/jpeg'),
          );

      var imageUrl = supabase.storage.from('images').getPublicUrl(fileName);
      setState(() {
        _imageFromGallary = imageUrl;
      });
    }
  }

  void _PostImage() async {
    if (_postController.text.isEmpty && _imageFromGallary == null) {
      return;
    }
    try {
      await supabase.from('posts').insert({
        "profile_image": widget.profilePic,
        "user_name": widget.userName,
        "caption": _postController.text.trim(),
        "post_image": _imageFromGallary,
      });

      _postController.text = "";
      _imageFromGallary = null;
    } catch (e) {
      print(e);
    }
  }

  void _addStory() async {
    if (_imageFromGallary == null) {
      return;
    }
    try {
      await supabase.from("stories").insert({
        "profile_image": widget.profilePic,
        "user_name": widget.userName,
        "story_image": _imageFromGallary,
      });

      _imageFromGallary = null;
    } catch (e) {
      print("Error while Fetching stories: ${e}");
    }
  }

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
                              backgroundImage: NetworkImage(widget.profilePic!),
                            ),

                            const SizedBox(width: 12),

                            Text(
                              widget.userName!,
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
                              child: ElevatedButton(
                                onPressed: _PostImage,
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
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        controller: _postController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 30,
                        //expands: true,
                        decoration: const InputDecoration(
                          hintText: "What's on your mind?",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),

                    SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AspectRatio(
                        aspectRatio: 8 / 9,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Center(
                                child: Image(
                                  image: (_imageFromGallary == null)
                                      ? NetworkImage(
                                          "https://imgs.search.brave.com/KG5WF95X3KUoOawg_riCYgzFRHtr_aoOKQYtrE82_PM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTMy/NDM1NjQ1OC92ZWN0/b3IvcGljdHVyZS1p/Y29uLXBob3RvLWZy/YW1lLXN5bWJvbC1s/YW5kc2NhcGUtc2ln/bi1waG90b2dyYXBo/LWdhbGxlcnktbG9n/by13ZWItaW50ZXJm/YWNlLWFuZC5qcGc_/cz02MTJ4NjEyJnc9/MCZrPTIwJmM9Wm1Y/TzRtU2dORFB6RFJY/LUY4T0tDZm1NcXFI/cHFNVjZqaU5pMDBZ/ZTdyRT0",
                                        )
                                      : NetworkImage(_imageFromGallary!),
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          /// Image Icon
                          Column(
                            children: [
                              IconButton(
                                onPressed: _pickImage,
                                icon: Icon(
                                  Icons.image,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              Text("Image", style: TextStyle(fontSize: 14)),
                            ],
                          ),

                          Column(
                            children: [
                              IconButton(
                                onPressed: _addStory,
                                icon: Icon(
                                  Icons.auto_stories,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              Text("Story", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1000),
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
