import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // HEADER SECTION (points 2-5)
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB3FFFD), Color(0xFFEFFFFF)],
                ),
              ),
              child: Column(
                children: [
                  // 3) TOP BAR (EDIT + DROPDOWN REMOVED)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Darlene',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 4) PROFILE AVATAR
                  const CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150x150.png?text=User',
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 5) PROFILE NAME
                  const Text(
                    'Darlene Beats',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 8),

                  // USERNAME
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // 13) TABS (ONLY POST) + 14-18 FEED SECTION
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // 13) TABS (MENTION REMOVED)
                    _buildTabs(),

                    const Divider(height: 1),

                    // 18) FEED LIST
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: const [
                          // 14) POST CARD
                          PostCard(),
                          SizedBox(height: 16),
                          PostCard(),
                        ],
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

  // 13) TABS WIDGET (ONLY POST TAB)
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
                Text('Post', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          // Tab indicator
          Container(height: 2, color: Colors.black),
        ],
      ),
    );
  }
}

// 14) POST CARD WIDGET
class PostCard extends StatelessWidget {
  const PostCard({super.key});

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
          // 15) POST HEADER
          _buildHeader(),

          const SizedBox(height: 12),

          // 16) POST CAPTION
          _buildCaption(),

          const SizedBox(height: 12),

          // 17) POST IMAGE
          _buildImage(),
        ],
      ),
    );
  }

  // 15) POST HEADER (avatar, name, timestamp)
  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
            'https://via.placeholder.com/80x80.png?text=N',
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Nilesh',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            SizedBox(height: 2),
          ],
        ),
      ],
    );
  }

  // 16) POST CAPTION TEXT
  Widget _buildCaption() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 13.5, height: 1.4, color: Colors.black),
        children: [
          TextSpan(
            text:
                "Discover adventure in Patagonia's peaks or serenity provence's ",
          ),
          TextSpan(
            text: '@hamlets',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
          ),
          TextSpan(text: ' - arrival'),
        ],
      ),
    );
  }

  // 17) POST IMAGE
  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        'https://imgs.search.brave.com/MR0VAZeSKSYTs6ZxfrFGIr4Z_ZgMDln0Ug-ECpeVqyk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wMzAv/NzQ3LzY0OC9zbWFs/bC9hLW1vdW50YWlu/LWxha2Utd2l0aC1h/LW1vdW50YWluLWlu/LXRoZS1iYWNrZ3Jv/dW5kLWFuZC1sYW5k/c2NhcGUtd2FsbHBh/cGVyLWZyZWUtcGhv/dG8uanBn',
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
