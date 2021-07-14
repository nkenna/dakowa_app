import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/screens/auth/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscure = true;

  Widget _codeField(){
    return SizedBox(
        width: 350,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: codeController,
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
                prefixIcon: Icon(Icons.email_rounded, color: Colors.grey, size: 16,),
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Enter Reset Code",
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/main_logo.png", width: 150,),
                SizedBox(height: 20,),
                Text(
                  "Reset account password by entering reset code from your email inbox",
                  style: TextStyle(letterSpacing: 1, color: Colors.black, fontFamily: 'KiwiMedium', fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),

                _codeField(),

                _passwordField(),

                SizedBox(height: 20,),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xff7cb32f)),
                          shape: MaterialStateProperty.all(StadiumBorder())
                      ),
                      onPressed: () async{
                        final resp = await Provider.of<AuthProvider>(context, listen: false).resetPassword(context, codeController.text, passwordController.text);
                        if(resp){
                          Get.offAll(() => LoginScreen());

                        }
                      },
                      child: Text("Reset Password",
                        style: TextStyle( color: Colors.white, fontFamily: 'KiwiRegular', fontSize: 12),)
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
