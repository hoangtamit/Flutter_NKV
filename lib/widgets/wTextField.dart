
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class wTextField{
  static Widget buildTextField(TextEditingController controller, String label,{bool readOnly = false,TextStyle? style,ValueChanged<String>? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        style: style,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          //filled: true, // phải bật cái này
          //fillColor: Colors.grey[400], // đổi thành màu tùy ý
        ),
        onChanged: onChanged, // Gán vào TextField
      ),
    );
  }
  static Widget buildNumberTextField(TextEditingController controller, String label,{bool readOnly = false,bool enable = false,TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: readOnly,
        enabled: enable,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        style: style,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          //filled: true, // phải bật cái này
          //fillColor: Colors.grey[400], // đổi thành màu tùy ý
        ),
      ),
    );
  }
  static Widget buildTextField_Number(BuildContext context,TextEditingController controller,String label,{bool readonly = false}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: controller,
      onChanged: (value) {
        try {
          if (value.isNotEmpty) {
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      readOnly: readonly,
    );
  }


}