import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_find_tracker/core/network/authrization.dart';
import 'package:lost_find_tracker/core/strings/failures.dart';
import 'package:lost_find_tracker/core/utils/dismiss_keyboard.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:lost_find_tracker/features/auth/data/models/user_model.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';
import 'package:lost_find_tracker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/materialWidget/app_bar_widget.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/dialogWidget/error_snackbar.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/itemWidget/text_field_item.dart';
import 'package:lost_find_tracker/injection_container.dart' as di;

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({Key? key}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  final _userNameController = TextEditingController();

  late AuthBloc _authBloc;

  String error = "";

  late UserModel userModel;

  final AuthLocalDataSource localDataSource = di.sl<AuthLocalDataSource>();

  Future<void> getUser() async {
    userModel = await localDataSource.loadUser();
    _emailController.text = userModel.email;
    _userNameController.text = userModel.name!;
    _phoneController.text = userModel.phoneNumber!;
    _passwordController.text = userModel.password;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authBloc = di.sl<AuthBloc>();
    getUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        appBar: AppBarWidget(appBar: AppBar(), title: 'User Profile'),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldItem(
                    controller: _userNameController,
                    textInputType: TextInputType.name,
                    labelText: "Name *",
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return error = 'Please fill this field';
                      }
                      return null;
                    },
                  ),
                  TextFieldItem(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    labelText: "Email *",
                    readOnly: true,
                    icon: Icons.alternate_email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return error = 'Please fill this field';
                      }
                      return null;
                    },
                  ),
                  TextFieldItem(
                    controller: _phoneController,
                    textInputType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    labelText: "Phone *",
                    textInputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    icon: Icons.phone_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return error = 'Please fill this field';
                      } else if (value.length != 10) {
                        return error = 'Please enter 10 number';
                      }
                      return null;
                    },
                  ),
                  Text(
                    'Note: If you don\'t need to change your password, leave it as it is.',
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.red),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldItem(
                    controller: _passwordController,
                    isPassword: true,
                    textInputType: TextInputType.visiblePassword,
                    labelText: "Password",
                    icon: Icons.lock_outline,
                    validator: (value) {
                      if (value!.length < 8) {
                        error = 'Please fill field at least 8 letters';
                        return error;
                      }
                      return null;
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
                                var password = userModel.password ==
                                        _passwordController.text
                                    ? userModel.password
                                    : _passwordController.text.trim();
                                User user = User(
                                    password: password,
                                    email: _emailController.text.trim(),
                                    name: _userNameController.text.trim(),
                                    phoneNumber: _phoneController.text.trim(),
                                    id: userModel.id);
                                _authBloc.add(EditUserEvent(user: user));
                              }
                            },
                            child: BlocConsumer<AuthBloc, AuthState>(
                              bloc: _authBloc,
                              listener: (context, state) {
                                if (state is EditAuthSuccessState) {
                                  showSuccessSnackBar(context,
                                      "Success update profile", Colors.green);
                                } else if (state is ErrorAuthState) {
                                  showSuccessSnackBar(
                                      context, state.message, Colors.red);
                                  if (state.message ==
                                      Authorization_FAILURE_MESSAGE) {
                                    logout(context);
                                  }
                                }
                              },
                              builder: (context, state) {
                                if (state is LoadingAuthState) {
                                  return CircularProgressIndicator(
                                      color: ColorsFave.whiteColor);
                                }
                                return Text(
                                  'Update',
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
    );
  }
}
