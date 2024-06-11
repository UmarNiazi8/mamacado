import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tenbytes/Resources/utils.dart';
import 'package:tenbytes/otp_viev.dart';
import 'package:get/get.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // var currentAppUser = FirebaseAuth.instance.currentUser;

  Future<String> signUpUser({
    required String user,
    required String email,
    required String password,
    required String confirmpassword,
    required String phoneNo,
  }) async {
    String res = "some error occur";
    try {
      if (user.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          confirmpassword.isNotEmpty ||
          phoneNo.isNotEmpty) {
        if (password.length < 6) {
          return "Password must be at least 6 characters long";
        }
        if (phoneNo.length != 11) {
          return "Phone number must be exactly 11 digits";
        }
        if (password != confirmpassword) {
          return "Passwords do not match";
        }
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'user': user,
          'uid': cred.user!.uid,
          'email': email,
          'password': password,
          'follower': [],
          'following': [],
          'phoneNo': phoneNo,
        });
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      Get.back();
      Fluttertoast.showToast(
          msg: exceptionHandler(err.code),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: (Colors.red).withOpacity(0.7),
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (err) {
      res = Error().toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "some error occur";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Find user document with provided email
        QuerySnapshot querySnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isEmpty) {
          res = "user not found";
        } else {
          // Get the first document (should be only one)
          QueryDocumentSnapshot userDoc = querySnapshot.docs.first;
          // Retrieve the password from the document
          String storedPassword = userDoc['password'];

          // Compare stored password with provided password
          if (storedPassword == password) {
            // Sign in the user
            await _auth.signInWithEmailAndPassword(
                email: email, password: password);
            res = "success";
          } else {
            res = "incorrect password";
          }
        }
      } else {
        res = "please enter both email and password";
      }
    } on FirebaseAuthException catch (err) {
      Get.back();
      Fluttertoast.showToast(
          msg: exceptionHandler(err.code),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: (Colors.red).withOpacity(0.7),
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future resetPassword(
    String email,
    BuildContext context,
  ) async {
    showLoadingDialog();
    try {
      _auth.sendPasswordResetEmail(email: email);
      Get.back();

      Fluttertoast.showToast(
          msg: "Password Reset email sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: (Colors.black).withOpacity(0.7),
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Get.back();
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<String> sendCodeToEmail({
    required String email,
    required String password,
    required String username,
    required String phone,
    required BuildContext context,
    // required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          phone.isNotEmpty) {
        EmailOTP myauth = EmailOTP();
        myauth.setConfig(
            appEmail: "191400081@gmail.com",
            appName: "MamaCado",
            userEmail: email,
            otpLength: 5,
            otpType: OTPType.digitsOnly);
        if (await myauth.sendOTP() == true) {
          // ignore: use_build_context_synchronously
          Fluttertoast.showToast(
              msg: "OTP has been sent to your email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);

          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                emailOTP: myauth,
                email: email,
                password: password,
                username: username,
                phone: phone,
              ),
            ),
          );
        } else {
          Get.back();
          Fluttertoast.showToast(
              msg: "Oops, OTP send failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        res = "success";
      } else {
        Get.back();
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (err) {
      Get.back();
      Fluttertoast.showToast(
          msg: exceptionHandler(err.code),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: (Colors.red).withOpacity(0.7),
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (err) {
      Get.back();
      Fluttertoast.showToast(
          msg: exceptionHandler(err.toString()),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: (Colors.red).withOpacity(0.7),
          textColor: Colors.white,
          fontSize: 16.0);
      return err.toString();
    }
    return res;
  }

  String exceptionHandler(String code) {
    switch (code) {
      case "invalid-credential":
        return "Your login credentials are invalid";
      case "weak-password":
        return "Your password must be at least 8 characters";
      case "email-already-in-use":
        return "User Already exists";
      case "invalid-email":
        return "This email address is not valid";
      case "user-not-found":
        return "User not found";
      case "wrong-password":
        return "Invalid email or password";
      default:
        return "Something went wrong";
    }
  }
}
