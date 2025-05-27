
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class wDropdownField{
  static Widget buildDropdownField(List<String> items, Function(String?) onChanged, {String? selectedValue}) {
    //selectedValue = items.contains(selectedValue) ? selectedValue : (items.isNotEmpty ? items.first : null);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}