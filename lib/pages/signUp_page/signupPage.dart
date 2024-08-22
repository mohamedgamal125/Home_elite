import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  // This will track the error state
  bool _isUsernameError = false;
  bool _isEmailError = false;
  bool _isPasswordError = false;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 18),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/images/arrow_back.png",
                width: 35,
              )),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/image.jpg",
                fit: BoxFit.fill,
                height: deviceHeight,
                width: deviceWidth,
              ),
              Padding(
                padding: EdgeInsets.only(left: 36),
                child: Form(
                  key: _formKey, // Form key
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 6,
                            decoration: BoxDecoration(color: Color(0xff9D7D43)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Text(
                              "Sign up",
                              style: GoogleFonts.alegreyaSansSc(
                                  textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff263A27))),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 36),
                            child: Row(
                              children: [
                                Text(
                                  "UserName",
                                  style: GoogleFonts.alegreyaSansSc(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "*",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6, right: 25),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: _isUsernameError ? 70 : 50,
                              child: TextFormField(
                                cursorColor: Colors.brown,
                                cursorHeight: 26,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.brown),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.brown, width: 2.0),
                                      borderRadius: BorderRadius.circular(12)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    setState(() {
                                      _isUsernameError = true;
                                    });
                                    return 'UserName is required'; // Empty string to trigger errorBorder
                                  }
                                  setState(() {
                                    _isUsernameError = false;
                                  });
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Email",
                                  style: GoogleFonts.alegreyaSansSc(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "*",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6, right: 25),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: _isEmailError ? 70 : 50,
                              child: TextFormField(
                                cursorColor: Colors.brown,
                                cursorHeight: 26,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.brown),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.brown, width: 2.0),
                                      borderRadius: BorderRadius.circular(12)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    setState(() {
                                      _isEmailError = true;
                                    });
                                    return 'Email is required'; // Empty string to trigger errorBorder
                                  }
                                  setState(() {
                                    _isEmailError = false;
                                  });
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Password",
                                  style: GoogleFonts.alegreyaSansSc(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "*",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6, right: 25),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: _isPasswordError ? 70 : 50,
                              child: TextFormField(
                                obscureText: true,
                                cursorColor: Colors.brown,
                                cursorHeight: 26,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.brown),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.brown, width: 2.0),
                                      borderRadius: BorderRadius.circular(12)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    setState(() {
                                      _isPasswordError = true;
                                    });
                                    return 'Password is required'; // Empty string to trigger errorBorder
                                  }
                                  setState(() {
                                    _isPasswordError = false;
                                  });
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 35, right: 20),
                        width: 300,
                        height: 53,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff9D7D43),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xff9D7D43)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: GoogleFonts.alegreyaSansSc(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.pushNamed(context, "/signup2");
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28, right: 12),
                        child: Text(
                          "By continue, you agree to accept our privacy & term of subject ",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
