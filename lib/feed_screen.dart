import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedScreen> {
  int currentIndex = 1;

  Widget _postWidget({
    required String profileImage,
    required String userName,
    required String caption,
    required String postImage,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),

      decoration: BoxDecoration(
        color: Colors.white54,
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
                  backgroundImage: NetworkImage(profileImage),
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
            child: Image.network(postImage, fit: BoxFit.cover),
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
              // Color.fromARGB(255, 210, 245, 235),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              _postWidget(
                profileImage: "https://randomuser.me/api/portraits/men/1.jpg",
                userName: "Rahim",
                caption:
                    "Discover adventure in Patagonia's peaks or serenity in Provence",
                postImage:
                    "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
              ),

              _postWidget(
                profileImage: "https://randomuser.me/api/portraits/women/2.jpg",
                userName: "Selim",
                caption: "Chasing sunsets and city lights ",
                postImage:
                    "https://cdn.pixabay.com/photo/2016/11/19/18/06/feet-1840619_640.jpg",
              ),

              _postWidget(
                profileImage: "https://randomuser.me/api/portraits/men/3.jpg",
                userName: "Sakif",
                caption:
                    "Fitness is not about being better than someone else. It's about being better than you used to be",
                postImage:
                    "https://images.unsplash.com/photo-1554284126-aa88f22d8b74",
              ),

              _postWidget(
                profileImage: "https://randomuser.me/api/portraits/women/4.jpg",
                userName: "Karim",
                caption: "Beach days are the best days ",
                postImage:
                    "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
              ),

              _postWidget(
                profileImage: "https://randomuser.me/api/portraits/men/5.jpg",
                userName: "Hossain",
                caption: "Late night coding sessions with coffee ",
                postImage:
                    "https://images.unsplash.com/photo-1519389950473-47ba0277781c",
              ),

              _postWidget(
                profileImage: "https://randomuser.me/api/portraits/women/6.jpg",
                userName: "Tosin",
                caption: "Nature heals everything ",
                postImage:
                    "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
              ),
            ],
          ),
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
      Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.network(
          "https://imgs.search.brave.com/4ADzYGgkY07mfEkKxUoxkPVkkAVujfy84nesQaZIOrk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/d2FsbHBhcGVyc2Fm/YXJpLmNvbS83OS8y/Ny9VTTV0NlMucG5n",
          fit: BoxFit.cover,
        ),
      ),

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
                      color: Color.fromARGB(25, 0, 0, 0),
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
