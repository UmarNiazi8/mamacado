import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tenbytes/Resources/auth_method.dart';
import 'package:tenbytes/widgets/custom_textField.dart';
import 'package:tenbytes/widgets/evaluated_button.dart';
import 'package:tenbytes/widgets/text_view.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        title: const Text(
          "Forgot Password",
          style: TextStyle(letterSpacing: -1),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      // centerTitle: true,
      // leading: GestureDetector(
      //   onTap: () {
      //     Navigator.of(context).pop();
      // },
      // child: const Padding(
      //   padding: EdgeInsets.all(16),
      //   child: Icon(
      //     Icons.arrow_back_ios,
      //     color: Colors.black,
      //   ),
      // ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  const TextView(
                    text: "Enter an Email to reset Password",
                    fontSize: 15,
                    fontfamily: 'RedHatTextBold',
                    textColor: Colors.red,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    isEmail: true,
                    isobscureText: false,
                    obscurechracter: "*",
                    hintText: "Email Address",
                    suffixIcon: const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  EvaluatedButton(
                    text: "Submit",
                    onPress: () {
                      if (formkey.currentState!.validate()) {
                        AuthMethods()
                            .resetPassword(_emailController.text, context);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please enter all the fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: (Colors.red).withOpacity(0.7),
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    isLoading: false,
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
