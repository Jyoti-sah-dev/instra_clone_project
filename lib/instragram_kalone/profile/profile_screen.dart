// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:video_player/video_player.dart';
// import '../auth/auth_controller.dart';
// import '../edit/editprofile.dart';
// import '../setting/setting_screen.dart';
// import '../user/user_controller.dart';
// import '../video_upload/video_upload_screen.dart';
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final UserController userController = Get.put(UserController());
//   final AuthController authController = Get.put(AuthController());
//   int postCount = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPostCount();
//   }
//
//   Future<void> _fetchPostCount() async {
//     try {
//       final videoSnapshot = await FirebaseFirestore.instance
//           .collection('videos')
//           .where('userId', isEqualTo: userController.user.value.id)
//           .get();
//       setState(() {
//         postCount = videoSnapshot.docs.length;
//       });
//     } catch (e) {
//       print("Error fetching post count: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           Text("Upload"),
//           IconButton(
//               onPressed: () {
//                 Get.to(() => VideoUploadScreen(
//                   onVideoUploaded: _refreshProfileScreen,
//                 ));
//               },
//               icon: Icon(Icons.add_box_outlined))
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
//             ),
//             child: Obx(() {
//               return Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: userController.userData.imageUrl != null
//                         ? NetworkImage(userController.userData.imageUrl!)
//                         : null,
//                     child: userController.user.value.imageUrl == null
//                         ? Icon(Icons.person, size: 50, color: Colors.grey)
//                         : null,
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           userController.userData.name ?? 'Username',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 24,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildProfileStat('Posts', postCount.toString()),
//                             _buildProfileStat(
//                                 'Followers',
//                                 userController.userData.followers?.length
//                                     .toString() ??
//                                     "0"),
//                             _buildProfileStat(
//                                 'Following',
//                                 userController.userData.following?.length
//                                     .toString() ??
//                                     "0"),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             OutlinedButton(
//                               onPressed: () {
//                                 Get.to(() => EditProfileScreen());
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               child: Text('Edit Profile'),
//                             ),
//                             SizedBox(height: 20,),
//                             OutlinedButton(
//                               onPressed: () {
//                                 Get.to(const SettingScreen());
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               child: const Text('Account Setting'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//           // Post Grid
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('videos')
//                   .where('userId', isEqualTo: userController.user.value.id)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 final videoDocs = snapshot.data?.docs ?? [];
//
//                 if (videoDocs.isEmpty) {
//                   return Center(child: Text('No videos uploaded yet.'));
//                 }
//
//                 return GridView.builder(
//                   padding: EdgeInsets.all(8.0),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 4.0,
//                   ),
//                   itemCount: videoDocs.length,
//                   itemBuilder: (context, index) {
//                     final videoData = videoDocs[index];
//                     final videoUrl = videoData['videoUrl'];
//                     return GestureDetector(
//                       onTap: () {
//                         Get.to(() => VideoPlaybackScreen(videoUrl: videoUrl));
//                       },
//                       child: Container(
//                         color: Colors.grey[300],
//                         child: Center(
//                           child: Icon(Icons.play_circle_outline,
//                               size: 50, color: Colors.black),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileStat(String title, String count) {
//     return Column(
//       children: [
//         Text(
//           count,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
//
//   _refreshProfileScreen() {
//     _fetchPostCount(); // Refresh the post count when a new video is uploaded
//     setState(() {});
//   }
// }
//
//
// class VideoPlaybackScreen extends StatefulWidget {
//   final String videoUrl;
//
//   VideoPlaybackScreen({required this.videoUrl});
//
//   @override
//   _VideoPlaybackScreenState createState() => _VideoPlaybackScreenState();
// }
//
// class _VideoPlaybackScreenState extends State<VideoPlaybackScreen> {
//   late VideoPlayerController _controller;
//   bool isPlaying = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _togglePlayPause() {
//     setState(() {
//       if (isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//       isPlaying = !isPlaying;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Video Playback'),
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//         body: Center(
//             child: _controller.value.isInitialized
//                 ? GestureDetector(
//               onTap: _togglePlayPause,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: VideoPlayer(_controller),
//                   ),
//                   if (!isPlaying)
//                     Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 80.0,
//                     ),
//                 ],
//               ),
//             )
//                 : CupertinoActivityIndicator(),
//         ),
//         );
//     }
// }
