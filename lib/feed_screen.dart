import 'package:flutter/material.dart';
import 'package:nextlink/profile.dart';
import 'dart:ui' as ui;
import 'post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

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
  // List<Map<String, dynamic>> posts = [
  //   {
  //     "profileImage": "https://randomuser.me/api/portraits/men/1.jpg",
  //     "userName": "Rahim",
  //     "caption":
  //         "Discover adventure in Patagonia's peaks or serenity in Provence",
  //     "postImage":
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpzBs1ZHuOoM98byXNDJcuUIGuf-c4SpMyoA&s",
  //   },
  //   {
  //     "profileImage": "https://randomuser.me/api/portraits/women/2.jpg",
  //     "userName": "Selim",
  //     "caption": "Chasing sunsets and city lights",
  //     "postImage":
  //         "https://imgs.search.brave.com/MR0VAZeSKSYTs6ZxfrFGIr4Z_ZgMDln0Ug-ECpeVqyk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wMzAv/NzQ3LzY0OC9zbWFs/bC9hLW1vdW50YWlu/LWxha2Utd2l0aC1h/LW1vdW50YWluLWlu/LXRoZS1iYWNrZ3Jv/dW5kLWFuZC1sYW5k/c2NhcGUtd2FsbHBh/cGVyLWZyZWUtcGhv/dG8uanBn",
  //   },
  //   {
  //     "profileImage": "https://randomuser.me/api/portraits/men/3.jpg",
  //     "userName": "Sakif",
  //     "caption":
  //         "Fitness is not about being better than someone else. It's about being better than you used to be",
  //     "postImage":
  //         "https://imgs.search.brave.com/pDA3Q3W7qvIo_6Y4fZf88Y0PaXCzSs-O4IDYLTuDJts/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJjYXZlLmNv/bS93cC93cDEyNTg4/MDQwLmpwZw",
  //   },
  //   {
  //     "profileImage": "https://randomuser.me/api/portraits/women/4.jpg",
  //     "userName": "Karim",
  //     "caption": "Beach days are the best days",
  //     "postImage":
  //         "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
  //   },
  //   {
  //     "profileImage": "https://randomuser.me/api/portraits/men/5.jpg",
  //     "userName": "Hossain",
  //     "caption": "Late night coding sessions with coffee",
  //     "postImage":
  //         "https://images.unsplash.com/photo-1519389950473-47ba0277781c",
  //   },
  //   {
  //     "profileImage": "https://randomuser.me/api/portraits/women/6.jpg",
  //     "userName": "Tosin",
  //     "caption": "Nature heals everything",
  //     "postImage":
  //         "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
  //   },
  // ];

  List<dynamic> stories = [null];
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/men/1.jpg",
  //   "userName": "Hosssain",
  //   "storyImage":
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpzBs1ZHuOoM98byXNDJcuUIGuf-c4SpMyoA&s",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/women/2.jpg",
  //   "userName": "Hosssain",
  //   "storyImage":
  //       "https://cdn.pixabay.com/photo/2016/11/19/18/06/feet-1840619_640.jpg",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/men/3.jpg",
  //   "userName": "Hosssain",
  //   "storyImage":
  //       "https://imgs.search.brave.com/MR0VAZeSKSYTs6ZxfrFGIr4Z_ZgMDln0Ug-ECpeVqyk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wMzAv/NzQ3LzY0OC9zbWFs/bC9hLW1vdW50YWlu/LWxha2Utd2l0aC1h/LW1vdW50YWluLWlu/LXRoZS1iYWNrZ3Jv/dW5kLWFuZC1sYW5k/c2NhcGUtd2FsbHBh/cGVyLWZyZWUtcGhv/dG8uanBn",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/women/4.jpg",
  //   "userName": "Hosssain",
  //   "storyImage":
  //       "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/men/5.jpg",
  //
  //   "storyImage":
  //       "https://images.unsplash.com/photo-1519389950473-47ba0277781c",
  // },
  // {
  //   "profileImage": "https://randomuser.me/api/portraits/women/6.jpg",
  //   "userName": "Hosssain",
  //   "storyImage":
  //       "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
  // },
  //

  Future<void> fetch_post() async {
    try {
      final data = await Supabase.instance.client
          .from('posts')
          .select()
          .order('created_at', ascending: false);

      setState(() {
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
      //print("Fetch Error: $e");
    }
  }

  int len = 0;

  Future<void> fetch_stories() async {
    try {
      final data = await Supabase.instance.client
          .from('stories')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        stories = (data as List).map((index) {
          dynamic currentTime = DateTime.now();
          dynamic uploadTime = index['created_at'];

          dynamic dateDiff = currentTime
              .difference(DateTime.parse(uploadTime))
              .inDays;
          if (dateDiff < 1) {
            return {
              'profileImage': index['profile_image']?.toString() ?? '',
              'userName': index['user_name']?.toString() ?? 'Anonymous',
              'storyImage': index['story_image']?.toString() ?? '',
              'createdAt': index['created_at'].toString(),
            };
          }
        }).toList();
      });
      len = stories.length;
      for (int i = 0; i < stories.length; i++) {
        if (stories[i] == null) len--;
      }

      //print("\n\n $dateDiff");
    } catch (e) {
      // print("Fetch Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetch_stories();
    fetch_post();
    Timer.periodic(const Duration(seconds: 1), (_) {
      fetch_post();
      fetch_stories();
    });
    setState(() {
      theUserName = widget.userName ?? "";
      thePP = widget.profilePic ?? "";
    });
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
                ClipOval(
                  child: profileImage.isNotEmpty
                      ? Image.network(
                          profileImage,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 40,
                              height: 40,
                              color: Colors.grey[300],
                              child: Icon(Icons.person, size: 20),
                            );
                          },
                        )
                      : Container(
                          width: 40,
                          height: 40,
                          color: Colors.grey[300],
                          child: Icon(Icons.person, size: 20),
                        ),
                ),
                SizedBox(width: 10),
                Text(
                  userName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),

          caption.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Text(caption, style: TextStyle(fontSize: 14)),
                )
              : Container(height: 0, width: 0, child: Text("")),

          postImage.isNotEmpty
              ? Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  width: double.infinity,
                  child: postImage.isNotEmpty
                      ? Image.network(postImage, fit: BoxFit.cover)
                      : SizedBox(),
                )
              : SizedBox(),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Row(
              children: [
                /// LIKE BUTTON
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    size: 28,
                    color: Colors.black,
                  ),
                ),

                SizedBox(width: 10),

                /// COMMENT BUTTON
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: 26,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _storyWidget({
    required String profileImage,
    required String storyImage,
  }) {
    return Container(
      width: 120,
      height: 180,
      margin: EdgeInsets.only(left: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: storyImage.isNotEmpty
                ? Image.network(
                    storyImage,
                    width: 120,
                    height: 180,
                    fit: BoxFit.cover,
                  )
                : Container(height: 0, width: 0, child: Text("")),
          ),

          Positioned(
            top: 8,
            left: 8,
            child: ClipOval(
              child: profileImage.isNotEmpty
                  ? Image.network(
                      profileImage,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 32,
                          height: 32,
                          color: Colors.grey[300],
                          child: Icon(Icons.person, size: 16),
                        );
                      },
                    )
                  : Container(width: 0, height: 0, child: Text("")),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        10,
        10,
      ), // equal top & bottom padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //APP LOGO
          ClipOval(
            child: Image.asset(
              'LOGO.png',
              width: 66,
              height: 66,
              fit: BoxFit.cover,
            ),
          ),

          // APP NAME
          Text(
            "Next Link",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          // ElevatedButton(
          //   onPressed: _addStory,
          //   child: Text(
          //     "Next Link",
          //     style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          //   ),
          // ),

          ///  USER PROFILE PIC
          ClipOval(
            child: widget.profilePic != null && widget.profilePic!.isNotEmpty
                ? Image.network(
                    widget.profilePic!,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 36,
                    height: 36,
                    color: Colors.grey[300],
                    child: Icon(Icons.person, size: 18),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _storiesSection() {
    return Positioned(
      top: 60,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 190,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: len,
          itemBuilder: (context, index) {
            final story = stories[index];

            return _storyWidget(
              profileImage: story["profileImage"]!,
              storyImage: story["storyImage"]!,
            );
          },
        ),
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
            colors: [Color.fromARGB(255, 168, 210, 255), Colors.white],
          ),
        ),

        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 120),
          itemCount: posts.length + 4,
          itemBuilder: (context, index) {
            if (index == 0) return _headerSection();
            if (index == 1) return SizedBox(height: 25);
            if (index == 2) {
              return (stories.length > 0 && stories[0] != null)
                  ? SizedBox(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: len,
                        itemBuilder: (context, index) {
                          final story = stories[index];

                          return _storyWidget(
                            profileImage: story["profileImage"]!,
                            storyImage: story["storyImage"]!,
                          );
                        },
                      ),
                    )
                  : Container(height: 0, width: 0, child: Text(""));
            }
            if (index == 3) return SizedBox(height: 10);
            int postIndex = index - 4;
            final post = posts[postIndex];
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
      PostScreen(userName: theUserName, profilePic: thePP),
      _feedPage(),

      // RIGHT PAGE
      ProfilePage(userName: theUserName, profilePic: thePP),
    ];

    return Scaffold(
      body: Stack(
        children: [
          pages[currentIndex],

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
                      width: 300,
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
