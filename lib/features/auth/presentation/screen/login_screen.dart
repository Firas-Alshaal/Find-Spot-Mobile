import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/utils/dismiss_keyboard.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';
import 'package:lost_find_tracker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:lost_find_tracker/features/auth/presentation/widget/auth_field.dart';
import 'package:lost_find_tracker/features/auth/presentation/widget/curved-left-shadow.dart';
import 'package:lost_find_tracker/features/auth/presentation/widget/curved-left.dart';
import 'package:lost_find_tracker/features/auth/presentation/widget/curved-right-shadow.dart';
import 'package:lost_find_tracker/features/auth/presentation/widget/curved-right.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/dialogWidget/error_snackbar.dart';
import 'package:lost_find_tracker/injection_container.dart' as di;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc _authBloc;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  String error = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authBloc = di.sl<AuthBloc>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DismissKeyboard(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: <Widget>[
              Positioned(top: 0, left: 0, child: CurvedLeftShadow()),
              Positioned(top: 0, left: 0, child: CurvedLeft()),
              Positioned(bottom: 0, left: 0, child: CurvedRightShadow()),
              Positioned(bottom: 0, left: 0, child: CurvedRight()),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 37.0, fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10.0),
                            margin: const EdgeInsets.only(right: 40.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 20.0,
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(90.0),
                                bottomRight: Radius.circular(90.0),
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AuthTextFieldItem(
                                    controller: _emailController,
                                    textInputType: TextInputType.emailAddress,
                                    text: "Email",
                                    icon: Icons.alternate_email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return error = 'Please fill this field';
                                      } else if (value.isNotEmpty) {
                                        bool valid = RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(_emailController.text);
                                        return valid == true
                                            ? null
                                            : error =
                                                'Please enter valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                  ),
                                  AuthTextFieldItem(
                                    controller: _passwordController,
                                    isPassword: true,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    text: "Password",
                                    icon: Icons.lock_outline,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        error = 'Please fill this field';
                                        return error;
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                User login = User(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());
                                _authBloc.add(LoginEvent(login: login));
                              } else {
                                showSuccessSnackBar(context, error, Colors.red);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(94, 201, 202, 1.0),
                                    Color.fromRGBO(119, 235, 159, 1.0),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10.0,
                                  )
                                ],
                              ),
                              child: BlocConsumer<AuthBloc, AuthState>(
                                bloc: _authBloc,
                                listener: (context, state) {
                                  if (state is AuthSuccessState) {
                                    _authBloc.add(GetCategoriesEvent());
                                  } else if (state is ErrorAuthState) {
                                    showSuccessSnackBar(
                                        context, state.message, Colors.red);
                                  } else if (state
                                      is GetCategoriesSuccessState) {
                                    Navigator.pushReplacementNamed(
                                        context, Constants.HomeScreen);
                                  } else if (state is ErrorGetCategoriesState) {
                                    showSuccessSnackBar(
                                        context, state.message, Colors.red);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoadingAuthState ||
                                      state is LoadingCategoriesState) {
                                    return CircularProgressIndicator(
                                      color: ColorsFave.whiteColor,
                                    );
                                  }

                                  return const Icon(
                                    Icons.check,
                                    size: 40.0,
                                    color: Colors.white,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "You don't have an account? ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: ColorsFave.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "Register",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: ColorsFave.attentionColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _authBloc.add(CancelAuthEvent());
                                    Navigator.pushReplacementNamed(
                                        context, Constants.RegisterScreen);
                                  },
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
