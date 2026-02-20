import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class FeedScreen extends StatefulWidget {
  final String? userName;
  final String? profilePic;

  const FeedScreen({
    required this.userName,
    required this.profilePic,
    super.key,
  });

  @override
  _FeedPageState createState() => _FeedPageState();
}

final supabase = Supabase.instance.client;



class _FeedPageState extends State<FeedScreen> {
  int currentIndex = 1;

  String? theUserName;
  String? thePP;

  List<Map<String, dynamic>> posts = [];
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/men/1.jpg",
  //   "userName": "Rahim",
  //   "caption":
  //   "Discover adventure in Patagonia's peaks or serenity in Provence",
  //   "postImage":
  //   "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/women/2.jpg",
  //   "userName": "Selim",
  //   "caption": "Chasing sunsets and city lights",
  //   "postImage":
  //   "https://cdn.pixabay.com/photo/2016/11/19/18/06/feet-1840619_640.jpg",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/men/3.jpg",
  //   "userName": "Sakif",
  //   "caption":
  //   "Fitness is not about being better than someone else. It's about being better than you used to be",
  //   "postImage":
  //   "https://images.unsplash.com/photo-1554284126-aa88f22d8b74",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/women/4.jpg",
  //   "userName": "Karim",
  //   "caption": "Beach days are the best days",
  //   "postImage":
  //   "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/men/5.jpg",
  //   "userName": "Hossain",
  //   "caption": "Late night coding sessions with coffee",
  //   "postImage":
  //   "https://images.unsplash.com/photo-1519389950473-47ba0277781c",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/women/6.jpg",
  //   "userName": "Tosin",
  //   "caption": "Nature heals everything",
  //   "postImage":
  //   "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
  // },




  Future<void> fetch_post() async {
    try {
      final data = await Supabase.instance.client
          .from('posts')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        // Mapping manually ensures that even if a DB cell is NULL,
        // your app receives an empty String '' instead of a crash.
        posts = (data as List).map((index) {
          return {
            'profileImage': index['profile_image']?.toString() ?? '',
            'userName': index['user_name']?.toString() ?? 'Anonymous',
            'caption': index['caption']?.toString() ?? '',
            'postImage': index['post_image']?.toString() ?? '',
          };
        }).toList();

      });
    } catch (e) {
      print("Fetch Error: $e");
    }
  }


  @override
  void initState() {
    super.initState();
    fetch_post();
    // setState(() {
    //   theUserName = widget.userName ?? "";
    //   thePP = widget.profilePic ?? "";
    // });
    // print("From FeedScreen:");
    // print(widget.userName);
    // print(widget.profilePic);
  }



  Widget _postWidget({
    required String profileImage,
    required String userName,
    required String caption,
    required String postImage,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: profileImage.isNotEmpty
                      ? NetworkImage(profileImage)
                      : null,
                ),
                SizedBox(width: 10),
                Text(
                  userName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text(caption, style: TextStyle(fontSize: 14)),
          ),

          Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: postImage.isNotEmpty
                  ? Image.network(postImage, fit: BoxFit.cover)
                  : SizedBox()
          ),
        ],
      ),
    );
  }

  Widget _feedPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: ListView.builder(
          padding: EdgeInsets.only(top: 250, bottom: 120),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return _postWidget(
              profileImage: post["profileImage"]!,
              userName: post["userName"]!,
              caption: post["caption"]!,
              postImage: post["postImage"]!,
            );
          },
        ),
      ),
    );
  }


  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      // LEFT PAGE
      PostScreen(),
      _feedPage(),

      // RIGHT PAGE
      Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.network(
          "https://imgs.search.brave.com/OcvkwtrQcsvMdsChQFkoxM53XhsWoFpzhM30FmKJRn8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvaGQvZjEt/cGhvbmUteWVsbG93/LXJlZC1mb3JtdWxh/LWNhci04a2VvczN1/cTRmdW5lcWR1LmpwZw",
          fit: BoxFit.cover,
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          pages[currentIndex],
          // ElevatedButton(
          //   onPressed: () async {
          //     try {
          //       await supabase.from('posts').insert({
          //         "profile_image": "https://randomuser.me/api/portraits/women/6.jpg",
          //         "user_name": "Tosin",
          //         "caption": "Nature heals everything",
          //         "post_image":
          //         "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
          //       });
          //     } catch (e) {
          //       print(e);
          //     }
          //   },
          //   child: const Text('Post Now'),
          // ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      height: 80,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(25, 0, 0, 0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: BottomNavigationBar(
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        backgroundColor: Color.fromARGB(5, 255, 255, 255),
                        selectedItemColor: Color.fromARGB(255, 168, 210, 255),
                        unselectedItemColor: Colors.white,
                        unselectedIconTheme: IconThemeData(opacity: 1),
                        selectedIconTheme: IconThemeData(opacity: 1, size: 35),
                        selectedLabelStyle: TextStyle(
                          fontSize: 12.5,
                          color: Colors.white,
                        ),

                        currentIndex: currentIndex,
                        onTap: _onItemTapped,
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.add_circle),
                            label: 'create',
                          ), // BottomNavigationBarItem

                          BottomNavigationBarItem(
                            icon: Icon(Icons.home_rounded),
                            label: 'home',
                          ), // BottomNavigationBarItem

                          BottomNavigationBarItem(
                            icon: Icon(Icons.person_rounded),
                            label: 'profile',
                          ), // BottomNavigationBarItem
                        ],
                      ), // BottomNavigationBar
                      // Padding
                    ), // Container
                  ), // BackdropFilter
                ), // Theme
              ), // ClipRRect
            ), // Center
          ), // Positioned
        ],
      ),
    );
  }
}