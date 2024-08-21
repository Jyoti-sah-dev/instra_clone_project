// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// class SearchScreen extends StatefulWidget {
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(() {
//       setState(() {
//         _searchQuery = _searchController.text;
//       });
//     });
//   }
//   Future<List<Map<String, dynamic>>> _fetchUsersWithPosts() async {
//     List<Map<String, dynamic>> usersWithPosts = [];
//
//     QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('users').get();
//     for (var userDoc in usersSnapshot.docs) {
//       String userId = userDoc.id;
//       QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
//           .collection('videos')
//           .where('userId', isEqualTo: userId)
//           .get();
//       if (postsSnapshot.docs.isNotEmpty) {
//         Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
//         userData['postCount'] = postsSnapshot.docs.length;
//         usersWithPosts.add(userData);
//       }
//     }
//     return usersWithPosts;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               hintText: 'Search users...',
//               hintStyle: TextStyle(color: Colors.black),
//               fillColor: Colors.white,
//               filled: true,
//               prefixIcon: Icon(Icons.search, color: Color(0xff71a08b)),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//           backgroundColor: Colors.teal,
//         ),
//         body: FutureBuilder<List<Map<String, dynamic>>>(
//             future: _fetchUsersWithPosts(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }
//
//               List<Map<String, dynamic>> users = snapshot.data!;
//               if (_searchQuery.isNotEmpty) {
//                 users = users.where((user) {
//                   final name = user['name']?.toLowerCase() ?? '';
//                   return name.contains(_searchQuery.toLowerCase());
//                 }).toList();
//               }
//
//               if (users.isEmpty) {
//                 return Center(child: Text('No users with posts found.'));
//               }
//               return ListView.builder(
//                 padding: EdgeInsets.all(8.0),
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   var user = users[index];
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: CachedNetworkImageProvider(user['imageUrl'] ?? ''),
//                     ),
//                     title: Text(user['name'] ?? 'Unknown'),
//                     subtitle: Text('${user['postCount']} posts'),
//                     onTap: () {
//                       // Handle user profile navigation if needed
//                     },
//                   );
//                 },
//               );
//             },
//             ),
//         );
//     }
// }
