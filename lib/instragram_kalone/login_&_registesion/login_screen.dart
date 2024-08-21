// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:insta_application/screens/auth_screen/registration_screen.dart';
// import '../../controller/auth_controller.dart';
// import '../home/home_screen.dart';
// import 'mixin_screen.dart';
//
// class LoginScreen extends StatelessWidget with CustomizeWidgets {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.find<AuthController>();
//
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//
//       body: Padding(
//         padding: const EdgeInsets.only(top: 120,left: 20,right: 20),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(height: 20),
//               Text(
//                 'Welcome Back!',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.indigo,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               buildTextField(
//                 controller: emailController,
//                 labelText: 'Email',
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
//                   prefixIcon:Icon(Icons.email)
//               ),
//               SizedBox(height: 15),
//               buildTextField(
//                 controller: passwordController,
//                 labelText: 'Password',
//                 obscureText: true,
//                 validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
//                   prefixIcon:Icon(Icons.lock)
//               ),
//               SizedBox(height: 30),
//               Obx(() {
//                 return buildButton(
//                   onPressed: () {
//                     authController.loginUser(emailController.text, passwordController.text);
//                     Get.to(HomeScreen());
//                   },
//                   text: 'Login',
//                   isLoading: authController.isLoading.value,
//
//                 );
//               }),
//               SizedBox(height: 20),
//               Center(
//                 child: InkWell(
//                   onTap: () {
//                     Get.offAll(RegisterScreen());
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Don’t have an account? ',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text("Register", style: TextStyle(
//                         color: Colors.indigo,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),)
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../auth/auth_controller.dart';
// import '../minix_class_/minix.dart';
//
//
//
// class LoginScreen extends StatelessWidget with ValidationMixin {
//   final AuthController authController = Get.find<AuthController>();
//
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Text('Login'),
//         backgroundColor: Colors.blue, // Changed to blue
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(Icons.lock, color: Colors.blue, size: 100), // Changed to blue
//                 SizedBox(height: 40),
//                 _buildTextField(_emailController, 'Email', Icons.email, false),
//                 SizedBox(height: 20),
//                 _buildTextField(_passwordController, 'Password', Icons.lock, true),
//                 SizedBox(height: 40),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_emailController.text.isNotEmpty &&
//                         _passwordController.text.isNotEmpty) {
//                       authController.loginWithEmailAndPassword(
//                         _emailController.text.trim(),
//                         _passwordController.text.trim(),
//                       );
//                     } else {
//                       Get.snackbar('Error', 'Please fill all fields.');
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     backgroundColor: Colors.blue, // Changed to blue
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: Text('Login', style: TextStyle(fontSize: 18)),
//                 ),
//                 SizedBox(height: 20),
//                 Text.rich(
//                   TextSpan(
//                     text: 'Don\'t have an account? ',
//                     style: TextStyle(color: Colors.blue), // Changed to blue
//                     children: [
//                       TextSpan(
//                         recognizer: TapGestureRecognizer()..onTap =(){
//                           Get.toNamed('/register');
//                         },
//                         text: 'Register',
//                         style: TextStyle(
//                           color: Colors.black, // Register text in black
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
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
//           prefixIcon: Icon(icon, color: Colors.blue), // Changed to blue
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         ),
//         obscureText: isPassword,
//         validator: isPassword ? validatePassword : validateEmail,
//         );
//     }
// }
