import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/category.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/search.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/materialWidget/dropdown_field.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/dialogWidget/pick_date.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/itemWidget/text_field_item.dart';
import 'package:lost_find_tracker/injection_container.dart' as di;

class SearchFilterDialog extends StatelessWidget {
  SearchFilterDialog({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  late String? categoryId = '';
  List<Category> listCategories = [];

  final AuthLocalDataSource localDataSource = di.sl<AuthLocalDataSource>();

  Future<List<Category>> getCategories() async {
    return await localDataSource.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Text(
        'Search Filter',
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldItem(
                  controller: _nameController,
                  icon: Icons.account_box_outlined,
                  labelText: 'Name',
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
                TextFieldItem(
                  controller: _dateController,
                  icon: Icons.date_range_outlined,
                  labelText: 'Date Time',
                  readOnly: true,
                  textInputType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                  onTap: () async {
                    await pickDateProject(context).then((value) =>
                        value != null ? _dateController.text = value : null);
                  },
                ),
                FutureBuilder(
                  future: getCategories(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Category>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return DropdownField(
                        list: snapshot.data!,
                        label: 'Category',
                        onChanged: (value) {
                          categoryId = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                      );
                    } else {
                      return DropdownField(
                        list: const [],
                        label: 'Category',
                        onChanged: (value) {
                          categoryId = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                      );
                    }
                  },
                ),
                TextFieldItem(
                  controller: _locationController,
                  icon: Icons.location_on_outlined,
                  labelText: 'Location',
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsFave.primaryColor),
                onPressed: () {
                  Navigator.of(context).pop(Search(
                      name: _nameController.text.trim(),
                      location: _locationController.text.trim(),
                      date: _dateController.text.trim(),
                      categoryId: categoryId!));
                },
                child: Text('Submit',
                    style: TextStyle(
                        color: ColorsFave.whiteColor,
                        fontSize: 17,
                        letterSpacing: 1.2)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
