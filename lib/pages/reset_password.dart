// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/widgets/common.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:email_otp/email_otp.dart';

final SupabaseClient supabase = SupabaseClient(
  'https://aiadfhpajrtlxjiypkuk.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFpYWRmaHBhanJ0bHhqaXlwa3VrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTkwMTQ2NjcsImV4cCI6MjAxNDU5MDY2N30.7XfE2XuXcueNRp8nbgXN52z3CYvpe7PeVXf4pB_V8t8',
);

class Reset extends StatefulWidget {
  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  late TextEditingController _emailController;
  late TextEditingController _otpController;
  late TextEditingController _newPasswordController;
  bool _passwordLoading = false;
  EmailOTP myAuth = EmailOTP();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _otpController = TextEditingController();
    _newPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();

    super.dispose();
  }

  Future<void> sendEmail() async {
    myAuth.setConfig(
        appEmail: "ausports@annauniv.edu",
        appName: "AU sports Email Verification",
        userEmail: _emailController.text,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
        
    if (await myAuth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("OTP has been sent"),
        backgroundColor: Colors.blueAccent,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Oops, OTP send failed"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  Future<void> update() async {
    try {
      final response = await supabase
          .from('user')
          .update({'password': _newPasswordController.text})
          .eq('email', _emailController.text)
          .execute();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("data updated"),
        backgroundColor: Colors.blueAccent,
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("data error"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  Future<void> resetpassword() async {
    if (await myAuth.verifyOTP(otp: _otpController.text) == true) {
      update();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("OTP is verified"),
        backgroundColor: Colors.blueAccent,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid OTP"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 900,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/images/student.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0xFF03498B).withOpacity(0.20),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 40, right: 100, top: 130),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 5,
                        top: 40,
                      ),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.04,
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.25,
                          right: 25,
                          left: 25),
                      child: Column(
                        children: [
                          TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'email should not be empty';
                                }
                                final isValid = RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(value);
                                if (!isValid) {
                                  return 'enter valid email';
                                }
                                return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.transparent.withOpacity(0.10),
                                  filled: true,
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              keyboardType: TextInputType.emailAddress),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await sendEmail();
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.blue;
                                  return null;
                                },
                              ),
                            ),
                            child: const Text(
                              'Send otp',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'otp is empty';
                                }
                                return null;
                              },
                              controller: _otpController,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.transparent.withOpacity(0.10),
                                  filled: true,
                                  labelText: 'OTP',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              keyboardType: TextInputType.number),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password should not be empty';
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters long";
                              }
                              if (!value.contains(RegExp(r'[A-Z]'))) {
                                return "Password must contain at least one uppercase letter";
                              }
                              if (!value.contains(RegExp(r'[a-z]'))) {
                                return "Password must contain at least one lowercase letter";
                              }
                              if (!value.contains(RegExp(r'[0-9]'))) {
                                return "Password must contain at least one numeric character";
                              }
                              if (!value.contains(
                                  RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                                return "Password must contain at least one special character";
                              }

                              return null;
                            },
                            controller: _newPasswordController,
                            decoration: InputDecoration(
                                fillColor: Colors.transparent.withOpacity(0.10),
                                filled: true,
                                labelText: 'new Password',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                          _passwordLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    margin: EdgeInsets.all(25),
                                    child: SizedBox(
                                      width: 230,
                                      height: 60,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await resetpassword();
                                        },
                                        style: ButtonStyle(
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.pressed))
                                                return Colors.blue;
                                              return null;
                                            },
                                          ),
                                        ),
                                        child: const Text(
                                          'Rest password',
                                          style: TextStyle(
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
