import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tenbytes/Resources/utils.dart';
import 'package:tenbytes/dashboard.dart';
import 'package:tenbytes/widgets/custom_textField.dart';
import 'package:tenbytes/widgets/svg_image_view.dart';

import 'package:tenbytes/Resources/auth_method.dart';
import 'package:tenbytes/widgets/text_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final nameController = TextEditingController();
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
  final confirmpasswordControler = TextEditingController();
  final phoneNoController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isloading = false;
  void signUpUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().signUpUser(
      user: nameController.text.trim(),
      email: emailControler.text.trim(),
      password: passwordControler.text.trim(),
      confirmpassword: confirmpasswordControler.text.trim(),
      phoneNo: phoneNoController.text.trim(),
    );

    if (res == 'success') {
      // Check for success
      // Clear text fields
      nameController.clear();
      emailControler.clear();
      passwordControler.clear();
      confirmpasswordControler.clear();
      phoneNoController.clear();

      // Navigate to Dashboard
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else {
      // Handle error cases
      setState(() {
        _isloading = false;
      });
      // Display error message based on 'res'
      switch (res) {
        case "Password must be at least 8 characters long":
          Fluttertoast.showToast(
            msg: "Password must be at least 8 characters long",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
          );
          break;
        case "Phone number must be exactly 11 digits":
          Fluttertoast.showToast(
            msg: "Phone number must be exactly 11 digits",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
          );
          break;
        // Add more cases for other error messages if needed
        default:
          // Display other error messages in the console
          print(res);
          break;
      }
    }
  }

  bool _isPasswordVisible1 = true;
  bool _isPasswordVisible2 = true;

  _toggleVisibility() {
    setState(() {
      _isPasswordVisible1 = !_isPasswordVisible1;
    });
  }

  _toggleVisibility2() {
    setState(() {
      _isPasswordVisible2 = !_isPasswordVisible2;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControler.dispose();
    passwordControler.dispose();
    nameController.dispose();
    confirmpasswordControler.dispose();
    phoneNoController.dispose();
  }

  void codeSend() async {
    // set loading to true
    // setState(() {
    //   _isLoading = true;
    // });
    showLoadingDialog();
    // signup user using our authmethodds
    String res = await AuthMethods().sendCodeToEmail(
        email: emailControler.text,
        password: passwordControler.text,
        username: nameController.text,
        context: context,
        phone: phoneNoController.text
        // file: _image!,
        );
    // if string returned is sucess, user has been created
    if (res == "success") {
      // Get.back();
      // setState(() {
      //   _isLoading = false;
      // });
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      // show the error
      // Get.back();
      Fluttertoast.showToast(
          msg: res,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFEE8EA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const SvgImageView(
                    svgHeight: 200,
                    svgWidth: 100,
                    svgPath: 'assets/3.svg',
                    fitType: BoxFit.cover,
                    imgcolor: Colors.pink,
                  ),
                  const TextView(
                    text: "Create your Account",
                    fontfamily: 'Pacifico',
                    fontSize: 28,
                    textColor: Colors.pink,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomTextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    isobscureText: false,
                    obscurechracter: "*",
                    hintText: "your name",
                    suffixIcon: const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: emailControler,
                    keyboardType: TextInputType.text,
                    isobscureText: false,
                    isEmail: true,
                    obscurechracter: "*",
                    hintText: "name@email.com",
                    isSuffixShow: true,
                    suffixIcon: const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: phoneNoController,
                    keyboardType: TextInputType.number,
                    isobscureText: false,
                    obscurechracter: "*",
                    hintText: "phone no",
                    isSuffixShow: true,
                    suffixIcon: const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: passwordControler,
                    keyboardType: TextInputType.text,
                    isobscureText: _isPasswordVisible1,
                    click: _toggleVisibility,
                    obscurechracter: "*",
                    hintText: "Create a Password",
                    isSuffixShow: true,
                    suffixIcon: _isPasswordVisible1
                        ? const Icon(CupertinoIcons.eye_slash)
                        : const Icon(CupertinoIcons.eye),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: confirmpasswordControler,
                    password: passwordControler.text,
                    keyboardType: TextInputType.text,
                    click: _toggleVisibility2,
                    isConfirmPassword: true,
                    isobscureText: _isPasswordVisible2,
                    obscurechracter: "*",
                    hintText: "Confirm Password",
                    isSuffixShow: true,
                    suffixIcon: _isPasswordVisible2
                        ? const Icon(CupertinoIcons.eye_slash)
                        : const Icon(CupertinoIcons.eye),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        codeSend();
                      } else {
                        print("please fill");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: const Size(300, 50),
                      backgroundColor: Colors.pink[500],
                      shadowColor: Colors.transparent,
                    ),
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ),
                          )
                        : const Text(
                            "Confirm",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
