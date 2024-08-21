import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instra_clone_project/application_project/setting_screens.dart';
import 'package:instra_clone_project/application_project/user_conroller.dart';
import 'package:instra_clone_project/application_project/videoupload_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'auth_controller_screen.dart';
import 'insta_editprofile_screen.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController userController = Get.put(UserController());
  final AuthController authController = Get.put(AuthController());
  int postCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchPostCount();
  }

  Future<void> _fetchPostCount() async {
    try {
      final videoSnapshot = await FirebaseFirestore.instance
          .collection('videos')
          .where('userId', isEqualTo: userController.user.value.id)
          .get();
      setState(() {
        postCount = videoSnapshot.docs.length;
      });
    } catch (e) {
      print("Error fetching post count: $e");
    }
  }

  Future<String?> _generateThumbnail(String videoUrl) async {
    try {
      final fileName = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 100,
        quality: 75,
      );
      return fileName;
    } catch (e) {
      print("Error generating thumbnail: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userController.userData.name ?? 'Username',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Text("Upload",style: TextStyle(fontSize: 18,color: Colors.black),),
          IconButton(
            onPressed: () {
              Get.to(() => VideoUploadScreen(
                onVideoUploaded: _refreshProfileScreen,
              ));
            },
            icon: Icon(Icons.add_box_outlined,size: 25,),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              // border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Obx(() {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: userController.userData.imageUrl != null
                        ? NetworkImage(userController.userData.imageUrl!)
                        : null,
                    child: userController.userData.imageUrl == null
                        ? Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                  child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              _buildProfileStat('Posts', postCount.toString()),
              _buildProfileStat(
              'Followers',
              userController.userData.followers?.length.toString() ?? "0",
              ),
              _buildProfileStat(
              'Following',
              userController.userData.following?.length.toString() ?? "0",
              ),

                ],
              )
                  )
              ]
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.to(() => EditProfileScreen());
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: BorderSide(color: Colors.black), // Set text color to black
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(width: 5), // Adjust spacing between buttons
                    OutlinedButton(
                      onPressed: () {
                        Get.to(() => SettingScreen());
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: BorderSide(color: Colors.black), // Set text color to black
                      ),
                      child: Text(
                        'Account Setting',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15), // Add some spacing before the divider
                Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.black, // Add a black border line
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildProfileStat(String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  _refreshProfileScreen() {
    _fetchPostCount(); // Refresh the post count when a new video is uploaded
    setState(() {});
  }
}


class VideoPlaybackScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlaybackScreen({required this.videoUrl});

  @override
  _VideoPlaybackScreenState createState() => _VideoPlaybackScreenState();
}

class _VideoPlaybackScreenState extends State<VideoPlaybackScreen> {
  late VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Playback'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
          onTap: _togglePlayPause,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: VideoPlayer(_controller),
          ),
        )
            : CupertinoActivityIndicator(),
      ),
    );
  }
}