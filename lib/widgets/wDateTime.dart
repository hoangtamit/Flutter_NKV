import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class wDateTime{
   static Widget buildDateTimeField(BuildContext context,String label, TextEditingController controller, Function(String?) onChanged,{bool readonly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readonly,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'dd/MM/yyyy HH:mm',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              selectDateTime(context, controller);
            },
          ),
        ),
        keyboardType: TextInputType.datetime,
        inputFormatters: [DateTimeInputFormatter()],
        onChanged: onChanged,
        onTap: () {
          if(!readonly) {
            FocusScope.of(context).requestFocus(new FocusNode());
            selectDateTime(context, controller);
          }
        },
      ),
    );
  }
  static  Future<void> selectDateTime(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        controller.text = DateFormat('dd/MM/yyyy HH:mm').format(fullDateTime);
      }
    }
  }
}
class DateTimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length == 2 && oldValue.text.length == 1 && !text.contains('/')) {
      text += '/';
    } else if (text.length == 5 && oldValue.text.length == 4 && !text.substring(3).contains('/')) {
      text += '/';
    } else if (text.length == 10 && oldValue.text.length == 9 && !text.substring(6).contains(' ')) {
      text += ' ';
    } else if (text.length == 13 && oldValue.text.length == 12 && !text.substring(11).contains(':')) {
      text += ':';
    }
    if (text.length > 16) {
      text = text.substring(0, 16);
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}