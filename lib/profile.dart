import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

class ProfilePage extends StatefulWidget {
  final String? userName;
  final String? profilePic;

  const ProfilePage({
    required this.userName,
    required this.profilePic,
    super.key,
  });
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

final supabase = Supabase.instance.client;

List<dynamic> posts = [];

class _ProfilePageState extends State<ProfilePage> {
  String? theUserName;
  String? thePP;

  Future<void> fetch_my_posts() async {
    try {
      final data = await Supabase.instance.client
          .from('posts')
          .select()
          .order('created_at', ascending: false);
      List<dynamic> allPosts = (data as List).map((index) {
        return {
          'profileImage': index['profile_image']?.toString() ?? '',
          'userName': index['user_name']?.toString() ?? 'Anonymous',
          'caption': index['caption']?.toString() ?? '',
          'postImage': index['post_image']?.toString() ?? '',
        };
      }).toList();

      List<dynamic> tempList = [];

      for (int i = 0; i < allPosts.length; i++) {
        if (allPosts[i]["userName"] == theUserName) {
          tempList.add(allPosts[i]);
        }
      }

      setState(() {
	posts.clear();
        posts.addAll(tempList);
      });
    } catch (e) {
      print("Fetch Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      theUserName = widget.userName ?? "";
      thePP = widget.profilePic ?? "";
    });
    fetch_my_posts();
    // Timer.periodic(const Duration(seconds: 1), (_) {
    //   fetch_my_posts();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 168, 210, 255),

                    Color.fromARGB(255, 255, 255, 255),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/LOGO.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const Expanded(
                          child: Center(
                            child: Text(
                              "Next Link",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 50),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(widget.profilePic!),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    widget.userName!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 8),

                  const SizedBox(height: 24),
                ],
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    //
                    _buildTabs(),

                    const Divider(height: 1),

                    Expanded(
                      child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              PostCard(index: index),
                              SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.grid_view_rounded, size: 18),
                SizedBox(width: 6),
                Text('Posts', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),

          Container(height: 2, color: Colors.black),
        ],
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final int index;

  const PostCard({required this.index, super.key});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),

          const SizedBox(height: 12),

          _buildCaption(),

          const SizedBox(height: 12),

          _buildImage(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
            posts[widget.index]["profileImage"]!,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              posts[widget.index]["userName"]!,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            SizedBox(height: 2),
          ],
        ),
      ],
    );
  }

  Widget _buildCaption() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 13.5, height: 1.4, color: Colors.black),
        children: [
          TextSpan(
            text:
                posts[widget.index]["caption"]!,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        posts[widget.index]["postImage"]!,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
