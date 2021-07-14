import 'package:dakowa_app/providers/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResendEmailScreen extends StatefulWidget {
  @override
  _ResendEmailScreenState createState() => _ResendEmailScreenState();
}

class _ResendEmailScreenState extends State<ResendEmailScreen> {
  TextEditingController emailController = TextEditingController();

  Widget _emailField(){
    return SizedBox(
        width: 350,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: emailController,
            style: TextStyle(fontSize: 14, color: Colors.black),
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
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
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
                SizedBox(height: 20,),
                Image.asset("assets/images/main_logo.png", height: 150,),
                SizedBox(height: 20,),
                Text(
                  "Enter the email address linked to your Dakowa account",
                  style: TextStyle(letterSpacing: 1, color: Colors.black, fontFamily: 'KiwiMedium', fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),

                _emailField(),

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
                        final resp = await Provider.of<AuthProvider>(context, listen: false).resendEmail(context, emailController.text);

                      },
                      child: Text("Resend Email",
                        style: TextStyle( color: Colors.white, fontFamily: 'KiwiRegular', fontSize: 14),)
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
