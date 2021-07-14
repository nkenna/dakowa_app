import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/screens/auth/forgotpasswordscreen.dart';
import 'package:dakowa_app/screens/auth/signup.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscure = true;

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

  Widget _passwordField(){
    return SizedBox(
        width: 350,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            obscureText: _obscure,
            controller: passwordController,
            style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular'),
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
                hintStyle: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular',color: Color(0xff0053a7))
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
            mainAxisSize: MainAxisSize.max,
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
                  "Hello Again, \nWelcome\nBack",
                  style: TextStyle(letterSpacing: 1, color: Colors.black, fontFamily: 'KiwiMedium', fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _emailField(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _passwordField(),
              ),
              SizedBox(height: 20,),

              SizedBox(
                height: 40,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xff7cb32f)),
                          //shape: MaterialStateProperty.all(StadiumBorder(

                          //))
                      ),
                      //onPressed: () => context.beamToNamed("/verify-account/1234567890"),
                      onPressed: () async{
                        var aProvider = Provider.of<AuthProvider>(context, listen: false);
                        if(emailController.text.isEmpty || passwordController.text.isEmpty){
                          print(111111111111);
                          LoadingControl.showSnackBar(
                              "Ouchs!!!",
                              "Email and Password are required",
                              Icon(Icons.error_rounded, color: Colors.orange,)
                          );

                          return;
                        }else if(emailController.text.contains("@") ==  false){
                          LoadingControl.showSnackBar(
                              "Ouchs!!!",
                              "Provided Email is invalid. Please provide valid email",
                              Icon(Icons.error_rounded, color: Colors.orange,)
                          );


                          return;
                        }else if(passwordController.text.length < 8){
                          LoadingControl.showSnackBar(
                              "Ouchs!!!",
                              "Password length must be more than 8 character",
                              Icon(Icons.error_rounded, color: Colors.orange,)
                          );
                          return;
                        }

                        final result =  await aProvider.loginUser(emailController.text, passwordController.text, context);
                        if(result){
                          //context.beamToNamed("/explore");
                        }
                      },
                      child: Text("Login",
                        style: TextStyle( color: Colors.white, fontFamily: 'KiwiRegular', fontSize: 14),)
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    InkWell(
                      onTap: () => Get.to(() => ForgotPasswordScreen()),
                      child: Text("Forgot Password?", style: TextStyle(
                          color: Colors.black, fontFamily: 'KiwiMedium', fontSize: 12),),
                    ),


                    // SizedBox(width: 20,),

                    InkWell(
                      onTap: () => Get.to(() => SignupScreen()),
                      child: Text("Signup", style: TextStyle(
                          decoration: TextDecoration.underline, color: Colors.black, fontFamily: 'KiwiMedium', fontSize: 12),),
                    )
                  ],
                ),
              ),

             // SizedBox(height: 30,),





            ],
          )
        ),
      ),
    );
  }
}
