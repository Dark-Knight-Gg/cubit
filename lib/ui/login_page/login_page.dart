import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../common/build_widget.dart';
import '../change_company/change_company_page.dart';
import '../forgot_password/forgot_password_bottom_sheet.dart';
import '../home_page/home_page.dart';
import 'cubit/password_visible_cubit.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  late bool _onPressButton;
  late bool _suffixIcon;
  @override
  void initState() {
    _onPressButton = true;
    _suffixIcon = true;
    userNameController.addListener(() {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(userNameController.text)) {
        passwordController.addListener(() {
          if (passwordController.text.length >= 7) {
            setState(() {
              _onPressButton = false;
            });
          } else {
            setState(() {
              _onPressButton = true;
            });
          }
        });
      } else {
        setState(() {
          _onPressButton = true;
        });
      }
    });
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty) {
        setState(() {
          _suffixIcon = false;
        });
      } else {
        setState(() {
          _suffixIcon = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<PassWordVisibleCubit, bool>(
        builder: (context, state){
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 100, 15, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildImageLogo('assets/images/logo.png'),
                    CusTomTextFieldNoIcon(
                        text: 'Nhập địa chỉ email...',
                        controller: userNameController,
                        isObsCurrentText: false),
                    CustomTextFieldHaveIcon(
                        text: 'Nhập mật khẩu...',
                        visible:state,
                        controller: passwordController,
                        suffixIcon:_suffixIcon),
                    CustomTextButton(
                        text: 'Quên mật khẩu',
                        builder: const ForgotPasswordBottomSheet()),
                    CustomButton(
                        text: 'Đăng nhập',
                        isActive: _onPressButton,
                        onPressed: onPressButton),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: MediaQuery.of(context).size.height / 3.5,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ChangeCompanyPage()),
                                  (route) => false);
                        },
                        child: Text(
                          'Thay đổi công ty?',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14, color: Colors.blueAccent)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Padding _buildImageLogo(String s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(110, 50, 110, 50),
      child: Image.asset(s),
    );
  }

  onPressButton() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const HomePage()), (route) => false);
  }
}
