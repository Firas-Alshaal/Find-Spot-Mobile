import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lost_find_tracker/core/network/authrization.dart';
import 'package:lost_find_tracker/core/strings/failures.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/utils/dismiss_keyboard.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:lost_find_tracker/features/goods/data/models/map_model.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/category.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/goods/goods_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/materialWidget/add_image_field.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/materialWidget/dropdown_field.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/dialogWidget/error_snackbar.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/dialogWidget/pick_date.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/dialogWidget/pick_image.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/itemWidget/text_field_item.dart';
import 'package:lost_find_tracker/injection_container.dart' as di;

class AddLostItemsScreen extends StatelessWidget {
  AddLostItemsScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  late String? categoryId;
  List<Category> listCategories = [];

  final ValueNotifier<XFile?> selectedImage = ValueNotifier(null);

  late MapModel? mapModel;

  final AuthLocalDataSource localDataSource = di.sl<AuthLocalDataSource>();

  Future<List<Category>> getCategories() async {
    return await localDataSource.loadCategories();
  }

  String convertToISO() {
    var date = intl.DateFormat("M/d/yyyy hh:mm").parse(_dateController.text);
    var formattedDate =
        intl.DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date);
    return formattedDate;
  }

  void clearField() {
    _nameController.clear();
    _descriptionController.clear();
    _dateController.clear();
    _locationController.clear();
    categoryId = null;
    selectedImage.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) {
        clearField();
      },
      child: DismissKeyboard(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsFave.primaryColor,
            toolbarHeight: MediaQuery.of(context).size.height * 0.07,
            leading: GestureDetector(
              onTap: () {
                clearField();
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
            title: Transform.translate(
              offset: const Offset(10, 0),
              child: Text(
                'Add Lost Item',
                style: GoogleFonts.roboto(),
              ),
            ).animate().fadeIn(delay: .3.seconds, duration: .2.seconds),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFieldItem(
                      controller: _nameController,
                      icon: Icons.account_box_outlined,
                      labelText: 'Name *',
                      textInputType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill this field';
                        }
                        return null;
                      },
                    ),
                    TextFieldItem(
                      controller: _descriptionController,
                      icon: Icons.description_outlined,
                      labelText: 'Description *',
                      textInputType: TextInputType.text,
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
                      labelText: 'Date Time *',
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
                            value != null
                                ? _dateController.text = value
                                : null);
                      },
                    ),
                    FutureBuilder(
                      future: getCategories(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Category>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return DropdownField(
                            list: snapshot.data!,
                            label: 'Category *',
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
                            label: 'Category *',
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
                      readOnly: true,
                      onTap: () {
                        Navigator.pushNamed(
                                context, Constants.PutLocationScreen)
                            .then((dynamic value) =>
                                value != null ? mapModel = value : null)
                            .then((value) => value != null
                                ? _locationController.text =
                                    '${mapModel!.country} ${mapModel!.city} ${mapModel!.formattedAddress}'
                                : null);
                      },
                      labelText: 'Location *',
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill this field';
                        }
                        return null;
                      },
                    ),
                    ValueListenableBuilder<XFile?>(
                      valueListenable: selectedImage,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () async {
                            await getImageFromGallery().then((value) =>
                                value != null
                                    ? selectedImage.value = value
                                    : null);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                color: Colors.blue.shade400,
                                child: selectedImage.value != null
                                    ? ImageContainer(
                                        selectedImage: selectedImage.value!)
                                    : const NoImageContainer(),
                              )),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsFave.primaryColor),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  LostItem lostItem = LostItem(
                                      name: _nameController.text.trim(),
                                      date: convertToISO(),
                                      city: mapModel!.city!,
                                      street: mapModel!.formattedAddress!,
                                      categoryId: categoryId!,
                                      lat: mapModel!.lat!,
                                      long: mapModel!.long!,
                                      images: selectedImage.value == null
                                          ? []
                                          : [selectedImage.value],
                                      description:
                                          _descriptionController.text.trim());
                                  BlocProvider.of<GoodsBloc>(context).add(
                                      AddLostItemEvent(
                                          lostItem: lostItem,
                                          itemType: ItemType.LOST));
                                }
                              },
                              child: BlocConsumer<GoodsBloc, GoodsState>(
                                listener: (context, state) {
                                  if (state is AddGoodsSuccessState) {
                                    showSuccessSnackBar(context,
                                        'Success Add Lost item', Colors.green);
                                    clearField();
                                    Navigator.pop(context);
                                  } else if (state is ErrorGoodsState) {
                                    showSuccessSnackBar(
                                        context, state.message, Colors.red);
                                    if (state.message ==
                                        Authorization_FAILURE_MESSAGE) {
                                      logout(context);
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoadingGoodsState) {
                                    return CircularProgressIndicator(
                                        color: ColorsFave.whiteColor);
                                  }
                                  return Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: ColorsFave.whiteColor,
                                        fontSize: 18),
                                  );
                                },
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
