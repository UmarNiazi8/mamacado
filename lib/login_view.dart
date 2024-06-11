import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tenbytes/Resources/auth_method.dart';
import 'package:tenbytes/dashboard.dart';
import 'package:tenbytes/forgot_password.dart';
import 'package:tenbytes/widgets/colors.dart';
import 'package:tenbytes/widgets/custom_textField.dart';
import 'package:tenbytes/widgets/svg_image_view.dart';
import 'package:tenbytes/widgets/text_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isloading = false;
  bool isPasswordVisible = false;

  void loginUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailControler.text, password: passwordControler.text);

    // if (mounted) {
    //   setState(() {
    //     // Update state here
    //   });
    // }

    // if (res != "success") {
    // } else {}
    // setState(() {
    //   bool _isloading = false;
    // });

    if (res == "success") {
      setState(() {
        _isloading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      setState(() {
        _isloading = false;
      });
      // Show a Snackbar with an error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  bool _isPasswordVisible1 = true;

  _toggleVisibility() {
    setState(() {
      _isPasswordVisible1 = !_isPasswordVisible1;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    emailControler.dispose();
    passwordControler.dispose();
    if (mounted) {
      super.dispose();
      // Cancel any active work here
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 100.0),
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SvgImageView(
                        svgHeight: 200,
                        svgWidth: 100,
                        svgPath: 'assets/3.svg',
                        imgcolor: Colors.pink,
                        fitType: BoxFit.cover),
                    SizedBox(
                      height: 15,
                    ),
                    TextView(
                      text: "Login to your Account",
                      fontfamily: 'Pacifico',
                      fontSize: 28,
                      textColor: Colors.pink,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomTextField(
                      controller: emailControler,
                      isEmail: true,
                      keyboardType: TextInputType.text,
                      isobscureText: false,
                      obscurechracter: "*",
                      hintText: "Email Address",
                      suffixIcon: const SizedBox.shrink(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: passwordControler,
                      keyboardType: TextInputType.text,
                      isobscureText: _isPasswordVisible1,
                      obscurechracter: "*",
                      hintText: "Password",
                      isSuffixShow: true,
                      click: _toggleVisibility,
                      suffixIcon: _isPasswordVisible1
                          ? const Icon(CupertinoIcons.eye_slash)
                          : const Icon(CupertinoIcons.eye),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordView()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 240),
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: appRedColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          loginUser();
                        } else {
                          print("please fill");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: const Size(300, 50),
                        backgroundColor: Colors.pink,
                        shadowColor: Colors.transparent,
                      ),
                      child: _isloading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1.0,
                              ),
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
