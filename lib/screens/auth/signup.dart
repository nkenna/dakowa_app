import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/screens/auth/loginscreen.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscure = true;
  bool _isCreator = true;
  bool _haveAgree = false;

  Widget _emailField(){
    return SizedBox(
        width: 350,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: emailController,
            style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,

            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffe9f0f4),
                contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: Icon(Icons.email_rounded, color: Colors.grey, size: 16,),
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Enter Email Address",
                hintStyle: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _usernameField(){
    return SizedBox(
        width: 350,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: usernameController,
            style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,

            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffe9f0f4),
                contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.grey, size: 16,),
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Enter unique name",
                hintStyle: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _passwordField(){
    return SizedBox(
        width: 350,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            obscureText: _obscure,
            controller: passwordController,
            style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,

            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffe9f0f4),
                contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey, size: 16,),
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Enter Password",
                hintStyle: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Container(
                width: 100,
                height: 70,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Center(
                  child: Image.asset("assets/images/main_logo.png"),
                ),
              ),
              //Image.asset("assets/images/main_logo.png", width: 150,),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Hello!, \nSignup to\nGet Started",
                  style: TextStyle(letterSpacing: 1, color: Colors.black, fontFamily: 'KiwiMedium', fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5,),
              CheckboxListTile(
                value: _isCreator,
                title: Text(
                  "Signup as a Creator",
                  style: TextStyle(fontSize: 12, color: Color(0xff0053a7), fontFamily: "KiwiRegular"),
                ),
                onChanged: (value){
                  setState(() {
                    _isCreator = value!;
                  });
                },
              ),
              SizedBox(height: 5,),
              _isCreator
                  ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _usernameField(),
              )
                  : Container(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _emailField(),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _passwordField(),
              ),

              SizedBox(height: 5,),
              CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                value: _haveAgree,
                onChanged: (value){
                  setState(() {
                    _haveAgree = value!;
                  });
                },
                title: Text("By signing up, you have agreed to our terms of use and privacy policy.",
                  style: TextStyle(letterSpacing: 1, color: Colors.black, fontFamily: 'KiwiRegular', fontSize: 12),),
              ),
              SizedBox(height: 5,),

              _haveAgree
                  ? SizedBox(
                height: 40,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xff7cb32f)),
                          shape: MaterialStateProperty.all(StadiumBorder())
                      ),
                      //onPressed: () => context.beamToNamed("/verify-account/1234567890"),
                      onPressed: (){
                        var aProvider = Provider.of<AuthProvider>(context, listen: false);
                        if(emailController.text.isEmpty || passwordController.text.isEmpty){
                          LoadingControl.showSnackBar(
                              "Ouchs!!!",
                              "Email and Password are required",
                              Icon(Icons.error, color: Colors.red,)
                          );
                          return;
                        }else if(emailController.text.contains("@") ==  false){
                          LoadingControl.showSnackBar(
                              "Ouchs!!!",
                              "Provided Email is invalid. Please provide valid email",
                              Icon(Icons.error, color: Colors.red,)
                          );
                          return;
                        }else if(passwordController.text.length < 8){
                          LoadingControl.showSnackBar(
                              "Ouchs!!!",
                              "Password length must be more than 8 characters",
                              Icon(Icons.error, color: Colors.red,)
                          );
                          return;
                        }else if(_isCreator && usernameController.text.isEmpty){
                          LoadingControl.showSnackBar(
                              "Ouchs!!!",
                              "creator unique name is required",
                              Icon(Icons.error, color: Colors.red,)
                          );
                          return;
                        }
                        else if(_isCreator && usernameController.text.isNotEmpty && usernameController.text.contains(" ")){
                          LoadingControl.showSnackBar(
                              "Ouchs!!!",
                              "creator unique name must be one word wth spaces",
                              Icon(Icons.error, color: Colors.red,)
                          );
                          return;
                        }

                        if(usernameController.text.isEmpty){
                          aProvider.createUserWithoutUserName(emailController.text, passwordController.text);
                        }else{
                          aProvider.createUserWithUserName(emailController.text, passwordController.text, "creator", usernameController.text.trim());
                        }


                      },
                      child: Text("Sign Up",
                        style: TextStyle( color: Colors.white, fontFamily: 'KiwiRegular', fontSize: 12),)
                  ),
                ),
              ) : Container(),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () => Get.to(() => LoginScreen()),
                  child: Text("Already have an account? Login", style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.black, fontFamily: 'KiwiMedium', fontSize: 12),),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
