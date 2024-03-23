import 'package:flutter/material.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/category.dart';

class DropdownField extends StatelessWidget {
  final List<Category> list;
  final ValueChanged onChanged;
  final FormFieldValidator validator;
  final String label;

  const DropdownField(
      {Key? key,
      required this.list,
      required this.onChanged,
      required this.label,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        items: list.map<DropdownMenuItem<String>>((Category category) {
          return DropdownMenuItem<String>(
            value: category.id,
            child: Text(category.name),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsFave.blackColor, width: 1.0)),
          border: const OutlineInputBorder(borderSide: BorderSide()),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(Icons.add_business_outlined),
          labelText: label,
        ),
      ),
    );
  }
}
