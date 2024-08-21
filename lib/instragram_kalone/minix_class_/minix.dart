// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// mixin CustomizeWidgets {
//   Widget buildTextField({
//     required TextEditingController controller,
//     required String labelText,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscureText = false,
//     String? Function(String?)? validator,
//     Widget? prefixIcon,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         labelText: labelText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         prefixIcon: prefixIcon,
//         filled: true,
//         fillColor: Colors.white,
//       ),
//       validator: validator,
//     );
//   }
//
//
//   Widget buildButton({
//     required VoidCallback onPressed,
//     required String text,
//     bool isLoading = false,
//   }) {
//     return ElevatedButton(
//       onPressed: isLoading ? null : onPressed,
//       child: isLoading
//           ? CircularProgressIndicator(color: Colors.white)
//           : Text(text, style: TextStyle(fontSize: 16,color: Colors.white)),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.indigo,
//         padding: EdgeInsets.symmetric(vertical: 16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
//
//   Widget buildImagePicker({
//     required VoidCallback onPressed,
//     required String imageUrl,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: CircleAvatar(
//         radius: 50,
//         backgroundImage: imageUrl.isEmpty ? null : NetworkImage(imageUrl),
//         child: imageUrl.isEmpty
//             ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
//             : null,
//       ),
//     );
//   }
// }


// lib/mixins/validation_mixin.dart

import 'package:get/get_utils/src/get_utils/get_utils.dart';

mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
    }
}
