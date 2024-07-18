import 'dart:convert';
import 'package:achievement_view/achievement_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:surebetcalc/constants/api.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/modals/alert.dart';
import 'package:surebetcalc/services/http.service.dart';
import 'package:surebetcalc/services/local_storage.dart';
import 'package:surebetcalc/widgets/GradientButton/GradientButton.dart';
import 'package:surebetcalc/widgets/curved_textfield.dart';
import 'package:surebetcalc/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //bool showGenderOptions = false;
  //String selectedGender = "";
  //bool male = true;
  //bool female = false;
  final _formKey = GlobalKey<FormState>();
  late AppProvider appProvider;
  bool loading = false;
  late TextEditingController usernameController;
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController emailController;
  late TextEditingController phonenoController;
  late TextEditingController accountNameController;
  late TextEditingController accountNoController;
  late TextEditingController bankController;
  Future getUsername() async {
    usernameController = TextEditingController(text: "");
    String username = await LocalStorage().getString("username");
    usernameController = TextEditingController(text: username);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    firstnameController = TextEditingController(
        text: appProvider.profileDetails?["firstName"] ?? "");
    lastnameController = TextEditingController(
        text: appProvider.profileDetails?["lastName"] ?? "");
    emailController =
        TextEditingController(text: appProvider.profileDetails?["email"] ?? "");
    phonenoController =
        TextEditingController(text: appProvider.profileDetails?["phone"] ?? "");
    accountNameController =
        TextEditingController(text: appProvider.profileDetails?["AccountName"]);
    accountNoController = TextEditingController(
        text: appProvider.profileDetails?["AccountNumber"]);
    bankController =
        TextEditingController(text: appProvider.profileDetails?["bankName"]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          backgroundColor: Color(0xff227324),
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
            text: "Profile",
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
                    text: "Personal Information",
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(text: "Update your personal information"),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Username",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: usernameController.text,
                    readOnly: true,
                    controller: usernameController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "First Name",
                    size: 16,
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
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Phone Number",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Phone Number",
                    controller: phonenoController,
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
                    text: "Account Name",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Account Name",
                    controller: accountNameController,
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
                    text: "Account Number",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Account Number",
                    controller: accountNoController,
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
                    text: "Bank",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    hint: "Bank",
                    controller: bankController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : GradientButton(
                          title: "Update",
                          clrs: [appColor, appColor],
                          onpressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateProfile();
                            }
                          },
                        ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateProfile() async {
    loading = true;
    setState(() {});
    try {
      Response response = await HttpService.post(Api.updateProfile, {
        "username": usernameController.text,
        "firstname": firstnameController.text,
        "lastname": lastnameController.text,
        "email": emailController.text,
        "phone": phonenoController.text,
        "accountname": accountNameController.text,
        "accountnumber": accountNoController.text,
        "bankname": bankController.text
      });
      Map res = jsonDecode(response.data);
      if (res["Status"] == "succcess") {
        appProvider.getProFileDetails(usernameController.text);
        AchievementView(
          color: appColor,
          icon: Image.asset(
            "assets/hand_up.png",
          ),
          title: "Success!",
          elevation: 20,
          subTitle: "Profile uploaded successfully",
          isCircle: true,
        ).show(context);
        Navigator.pop(context);
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ShowDialogWidget(
                  titleText: res["Report"],
                  subText:
                      "Please make sure you have input the datas correctly",
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                titleText: "Error",
                subText: "Please check your internet connection and try again",
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
