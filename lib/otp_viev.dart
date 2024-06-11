import 'package:email_otp/email_otp.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tenbytes/Resources/auth_method.dart';
import 'package:tenbytes/Resources/utils.dart';
import 'package:tenbytes/dashboard.dart';
import 'package:tenbytes/widgets/text_view.dart';
import 'package:timer_button/timer_button.dart';

class OtpScreen extends StatefulWidget {
  final EmailOTP emailOTP;
  final String email;
  final String password;
  final String username;
  final String phone;
  const OtpScreen({
    Key? key,
    required this.emailOTP,
    required this.email,
    required this.password,
    required this.username,
    required this.phone,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  void signUpUser() async {
    // set loading to true
    // setState(() {
    //   _isLoading = true;
    // });
    showLoadingDialog();
    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
      email: widget.email,
      password: widget.password,
      confirmpassword: widget.password,
      user: widget.username,
      phoneNo: widget.phone,
      // file: _image!,
    );
    // if string returned is sucess, user has been created
    if (res == "success") {
      // setState(() {
      //   _isLoading = false;
      // });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
      );
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      // show the error
      // Fluttertoast.showToast(
      //     msg: res,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: (Colors.red).withOpacity(0.7),
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        title: const Text(
          "OTP View",
          style: TextStyle(letterSpacing: -1),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Column(
              children: [
                const TextView(
                  text: "Enter Confirmation code",
                  fontSize: 18,
                  textAlign: TextAlign.center,
                  textColor: Colors.black,
                ),
                const TextView(
                  text: "A 6-digit code was sent to",
                  fontSize: 15,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  textColor: Colors.grey,
                ),
                TextView(
                  text: widget.email,
                  fontSize: 15,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  textColor: Colors.grey,
                ),
                const SizedBox(height: 60),
                OtpTextField(
                  textStyle: const TextStyle(
                      color: Colors.black, fontFamily: 'RedHatDisplayRegular'),
                  numberOfFields: 5,
                  borderRadius: BorderRadius.circular(5),
                  fieldWidth: 50,
                  borderColor: Colors.grey,
                  focusedBorderColor: Colors.black,
                  disabledBorderColor: Colors.grey,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) async {
                    if (await widget.emailOTP
                            .verifyOTP(otp: verificationCode) ==
                        true) {
                      signUpUser();
                      Fluttertoast.showToast(
                          msg: "Otp is successfuly verified",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: (Colors.black).withOpacity(0.7),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Invalid OTP",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: (Colors.red).withOpacity(0.7),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }, // end onSubmit
                ),
                const SizedBox(
                  height: 50,
                ),
                // _isLoading
                //     ? Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 46),
                //         child: EvaluatedButton(
                //           text: "",
                //           onPress: () {},
                //           isLoading: true,
                //         ),
                //       )
                //     : Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 46),
                //         child: EvaluatedButton(
                //           text: "Continue",
                //           onPress: () {
                //             if (formkey.currentState!.validate()) {
                //               signUpUser();
                //             }
                //           },
                //           isLoading: false,
                //         ),
                //       ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 200,
                  child: TimerButton(
                    label: "Resend",
                    timeOutInSeconds: 60,
                    onPressed: () async {
                      widget.emailOTP.setConfig(
                          appEmail: "191400081@gift.edu.pk",
                          appName: "MamaCado",
                          userEmail: widget.email,
                          otpLength: 5,
                          otpType: OTPType.digitsOnly);
                      if (await widget.emailOTP.sendOTP() == true) {
                        // ignore: use_build_context_synchronously
                        Fluttertoast.showToast(
                            msg: "OTP has been sent to your email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: (Colors.black).withOpacity(0.7),
                            textColor: Colors.white,
                            fontSize: 16.0);

                        // ignore: use_build_context_synchronously
                      } else {
                        Fluttertoast.showToast(
                            msg: "Oops, OTP send failed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: (Colors.red).withOpacity(0.7),
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    buttonType: ButtonType.outlinedButton,
                    disabledColor: Colors.pink,
                    color: Colors.black,
                    activeTextStyle: const TextStyle(color: Colors.black),
                    disabledTextStyle: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
