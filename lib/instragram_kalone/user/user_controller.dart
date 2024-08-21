// import 'dart:convert';
// import 'package:your_project/controllers/user_controller.dart';  // Adjust the path accordingly
//
// ;
// import 'package:get/get.dart';
//
// import '../model_class/model.dart';
// import 'package:get/get.dart';
//
// class UserController extends GetxController {
//   // Your controller logic here
// }
// class UserController extends GetxController {
//   Rx<UserModel> user = UserModel().obs;
//   UserModel get userData => user.value;
//   String? get userId => FirebaseAuth.instance.currentUser?.uid;
//
//   @override
//   void onInit() {
//     getUserData();
//     super.onInit();
//   }
//
//   getUserData() {
//     var userId = FirebaseAuth.instance.currentUser?.uid;
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .snapshots()
//         .listen(
//           (doc) {
//         var data = UserModel.fromJson(jsonDecode(jsonEncode(doc.data())));
//         user.value = data;
//       },
//     );
//   }
//
//   addToFollowing(String? authorId) {
//     FirebaseFirestore.instance.collection('users').doc(userId).update({
//       "following": FieldValue.arrayUnion([authorId])
//
//     });
//     FirebaseFirestore.instance.collection('users').doc(authorId).update({
//       "followers":FieldValue.arrayUnion([userId])
//     });
//   }
//   removeFromFollowing(String? authorId) {
//     FirebaseFirestore.instance.collection('users').doc(userId).update({
//       "following": FieldValue.arrayRemove([authorId])
//
//     });
//     FirebaseFirestore.instance.collection('users').doc(authorId).update({
//       "followers":FieldValue.arrayRemove([userId])
//       });
//     }
// }
