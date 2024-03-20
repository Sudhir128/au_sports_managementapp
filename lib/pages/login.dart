// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/myApp_materialPage.dart';
import 'package:flutter_application_1/pages/Register.dart';
import 'package:flutter_application_1/pages/reset_password.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient supabase = SupabaseClient(
  'https://aiadfhpajrtlxjiypkuk.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFpYWRmaHBhanJ0bHhqaXlwa3VrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTkwMTQ2NjcsImV4cCI6MjAxNDU5MDY2N30.7XfE2XuXcueNRp8nbgXN52z3CYvpe7PeVXf4pB_V8t8',
);

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _signInLoading = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _rollnoController;
  GlobalKey<FormState> _formkey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _rollnoController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _rollnoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final isValid = _formkey.currentState?.validate();
    if (isValid != true) {
      return;
    }
    setState(() {
      _signInLoading = true;
    });

    try {
      final response = await Supabase.instance.client
          .from('user')
          .select('email, rollnumber, password')
          .eq('email', _emailController.text)
          .eq('password', _passwordController.text)
          .single()
          .execute();
      final user = response.data;
      if (user != null &&
          user['password'] == _passwordController.text &&
          user['rollnumber'] == _rollnoController.text) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Logged in sucessfully'),
            backgroundColor: Colors.blueAccent));
        _navigateToDashboard();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Invaid credentials'), backgroundColor: Colors.red));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed'), backgroundColor: Colors.red));
    } finally {
      setState(() {
        _signInLoading = false;
      });
    }
  }

  void _navigateToDashboard() {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => Home()), (route) => false);
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
        child: Form(
          key: _formkey,
          child: Scaffold(
            backgroundColor: Color(0xFF03498B).withOpacity(0.20),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          padding:
                              EdgeInsets.only(left: 50, right: 240, top: 250),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blue[500],
                                fontSize: 32,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0.04,
                              ),
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(
                            left: 150,
                            right: 280,
                            top: 250,
                          ),
                          child: Text(
                            '|',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.04,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(
                          left: 170,
                          right: 110,
                          top: 250,
                        ),
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 32,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.04,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 40,
                          right: 120,
                          top: 340,
                        ),
                        child: Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.04,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.45,
                              right: 25,
                              left: 25),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'email should not be empty';
                                  }
                                  return null;
                                },
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    fillColor:
                                        Colors.transparent.withOpacity(0.10),
                                    filled: true,
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'roll should not be empty';
                                  }
                                  return null;
                                },
                                controller: _rollnoController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    fillColor:
                                        Colors.transparent.withOpacity(0.10),
                                    filled: true,
                                    labelText: 'roll no',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'password should not be empty';
                                  }
                                  return null;
                                },
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    fillColor:
                                        Colors.transparent.withOpacity(0.10),
                                    filled: true,
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                              SizedBox(
                                height: 0.4,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 140,
                                ),
                                child: TextButton(
                                    child: Text('Forgot Password?'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Reset(),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _signInLoading
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
                                            onPressed:
                                                _signInLoading ? null : _signIn,
                                            style: ButtonStyle(
                                              overlayColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return Colors.blue;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            child: const Text(
                                              'Sign in',
                                              style: TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              TextButton(
                                  child:
                                      Text('Don’t have an account? Sign up '),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Register(),
                                      ),
                                    );
                                  })
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
        ));
  }
}
