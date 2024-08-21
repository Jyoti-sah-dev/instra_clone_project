// import 'dart:io';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../auth/auth_controller.dart';
// import '../minix_class_/minix.dart';
//
//
// class RegistrationScreen extends StatefulWidget {
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> with ValidationMixin {
//   final AuthController authController = Get.find<AuthController>();
//
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _phoneController = TextEditingController();
//   File? _image;
//
//   final _formKey = GlobalKey<FormState>();  // Added a form key for validation
//
//   Future<void> _pickImage() async {
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Text('Register'),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundColor: Colors.blue.withOpacity(0.2),
//                     backgroundImage: _image != null ? FileImage(_image!) : null,
//                     child: _image == null
//                         ? Icon(Icons.camera_alt, color: Colors.blue, size: 50)
//                         : null,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Upload Profile Picture',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 _buildTextField(_nameController, 'Name', Icons.person, false),
//                 SizedBox(height: 20),
//                 _buildTextField(_emailController, 'Email', Icons.email, false),
//                 SizedBox(height: 20),
//                 _buildTextField(_passwordController, 'Password', Icons.lock, true),
//                 SizedBox(height: 20),
//                 _buildTextField(_phoneController, 'Phone', Icons.phone, false),
//                 SizedBox(height: 40),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate() && _image != null) {
//                       authController.registerWithEmailAndPassword(
//                         _nameController.text.trim(),
//                         _emailController.text.trim(),
//                         _passwordController.text.trim(),
//                         _phoneController.text.trim(),
//                         _image!,
//                       );
//                       Get.toNamed('/home');
//                     } else {
//                       Get.snackbar('Error', 'Please fill all fields and pick an image.');
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: Text('Register', style: TextStyle(fontSize: 18)),
//                 ),
//                 SizedBox(height: 20),
//                 Text.rich(
//                   TextSpan(
//                     text: 'Already have an account? ',
//                     style: TextStyle(color: Colors.blue),
//                     children: [
//                       TextSpan(
//                         recognizer: TapGestureRecognizer()..onTap = () {
//                           Get.toNamed('/login');
//                         },
//                         text: 'Login',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, bool isPassword) {
//     return TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: labelText,
//           prefixIcon: Icon(icon, color: Colors.blue),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         ),
//         obscureText: isPassword,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter your $labelText';
//           }
//           return null;
//       },
//         );
//     }
// }
