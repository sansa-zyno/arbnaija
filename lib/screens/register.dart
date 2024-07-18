import 'dart:convert';
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:surebetcalc/constants/api.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/helpers/common.dart';
import 'package:surebetcalc/screens/home.dart';
import 'package:surebetcalc/screens/login.dart';
import 'package:surebetcalc/modals/alert.dart';
import 'package:surebetcalc/services/http.service.dart';
import 'package:surebetcalc/services/local_storage.dart';
import 'package:surebetcalc/widgets/curved_textfield.dart';
import 'package:surebetcalc/widgets/custom_text.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController refererController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController banknameController = TextEditingController();
  TextEditingController accountnameController = TextEditingController();
  TextEditingController accountnoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  bool obscurePass1 = false;
  bool obscurePass2 = false;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          backgroundColor: Color(0xff227324),
          surfaceTintColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: CustomText(
            text: "Create an Account",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Username",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Username",
                    controller: usernameController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Promo Name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Promo Name",
                    controller: refererController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "First Name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "First Name",
                    controller: firstnameController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Last Name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Last Name",
                    controller: lastnameController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Email",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                      hint: "Email",
                      controller: emailController,
                      validator: (value) {
                        return validateEmail(emailController.text)
                            ? null
                            : "Enter a valid email address";
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Phone Number",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Phone Number",
                    controller: phoneController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Password",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Password",
                    obscureText: obscurePass1,
                    maxlines: 1,
                    controller: passwordController,
                    suffixIcon: IconButton(
                        onPressed: () {
                          obscurePass1 = !obscurePass1;
                          setState(() {});
                        },
                        icon: !obscurePass1
                            ? Icon(
                                Icons.visibility_off,
                                color: appColor,
                              )
                            : Icon(
                                Icons.visibility,
                                color: appColor,
                              )),
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      } else if (value!.length < 6) {
                        return "The password has to be at least 6 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Confirm Password",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Confirm Password",
                    obscureText: obscurePass2,
                    maxlines: 1,
                    controller: cpasswordController,
                    suffixIcon: IconButton(
                        onPressed: () {
                          obscurePass2 = !obscurePass2;
                          setState(() {});
                        },
                        icon: !obscurePass2
                            ? Icon(
                                Icons.visibility_off,
                                color: appColor,
                              )
                            : Icon(
                                Icons.visibility,
                                color: appColor,
                              )),
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      } else if (value!.length < 6) {
                        return "The password has to be at least 6 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text:
                        "BANK ACCOUNT INFORMATION FOR WITHDRAWING YOUR EARNINGS",
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Bank Name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Bank Name",
                    controller: banknameController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Account Name",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Account Name",
                    controller: accountnameController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Account Number",
                    size: 16,
                    color: appColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Account Number",
                    controller: accountnoController,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  /* Row(
                    children: [
                      Checkbox(
                          fillColor: MaterialStateProperty.all(appColor),
                          value: true,
                          onChanged: (val) {
                            val = !val!;
                          }),
                      SizedBox(
                        width: 15,
                      ),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(color: black, fontSize: 16),
                              children: [
                            TextSpan(text: "I Agree to the\n"),
                            TextSpan(
                                style: TextStyle(
                                  color: appColor,
                                ),
                                text: "terms and conditions")
                          ]))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomText(
                      text:
                          "You are adviced to read the terms and conditions"),
                  SizedBox(
                    height: 15,
                  ),*/
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              signup();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: appColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: "Proceed",
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(text: "Already have an account? "),
                              TextSpan(
                                  style: TextStyle(color: Color(0xff921006)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => changeScreen(context, Login()),
                                  text: "Log in")
                            ])),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signup() async {
    loading = true;
    setState(() {});
    try {
      final apiResult = await HttpService.post(
        Api.register,
        {
          "username": usernameController.text,
          "referer": refererController.text,
          "firstName": firstnameController.text,
          "lastName": lastnameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "bankname": banknameController.text,
          "accountname": accountnameController.text,
          "accountnumber": accountnoController.text,
          "password": passwordController.text,
          "cpassword": cpasswordController.text
        },
      );
      final result = jsonDecode(apiResult.data);
      log(result.toString());
      if (result["Status"] == "succcess") {
        LocalStorage().setString("username", usernameController.text);
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: Home(
                  username: usernameController.text,
                )),
            (route) => false);
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ShowDialogWidget(
                  titleText: result["Report"],
                  subText: "",
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                titleText: e.toString(),
                subText: "",
              ));
    }
    loading = false;
    setState(() {});
  }
}

bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
