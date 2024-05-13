import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Interact\n\n'
              'Welcome to Interact, a dynamic social media platform where connections are made vibrant and meaningful. At Interact, we believe in the power of communication and the magic of keeping relationships alive through digital interaction.\n\n'
              'Features:\n'
              '- Post & Share: Dive into a seamless experience where you can post your thoughts, share your moments, and express yourself freely. Whether it\'s a photo, video, or text, Interact lets you share your world.\n'
              '- Edit & Delete Posts: Have full control over your content. Change your mind? Edit or delete your posts anytime.\n'
              '- Engage with Content: Show your appreciation by liking and commenting on posts. Engage in discussions, share your opinions, and connect with others.\n'
              '- Follow/Unfollow: Build your network by following friends and influencers. Customize your feed by choosing whom to follow while also having the option to unfollow.\n'
              '- Private Messaging: Chat privately with your friends and family. Our messaging feature ensures that you stay connected with your loved ones no matter where you are.\n\n'
              'At Interact, we are committed to providing a platform that not only entertains but also fosters genuine connections and community building. Join us to experience a world where every interaction matters.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
