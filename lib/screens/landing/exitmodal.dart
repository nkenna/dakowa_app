import 'package:dakowa_app/screens/auth/loginscreen.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:dakowa_app/utils/sharedprefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ExitModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Center(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: SizedBox(
          width: Get.width * 0.8,
          height: 200,
          child: Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      //color: Colors.red,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Are you leaving us?",
                            style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: double.infinity,

                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.red),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topRight: Radius.circular(30)),
                                  ))
                              ),
                              onPressed: (){
                                Get.back();
                              },
                              icon: Icon(Icons.close_rounded, color: Colors.white, size: 12,),
                              label: Text("close", style: TextStyle(color: Colors.white, fontFamily: 'KiwiRegular', fontSize: 12),)
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(

                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              child: Text("You are about to log out. Do you still want to continue?",
                                      style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular'),)
                            ),


                          ],
                        ),
                      ),
                    )
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      //color: Colors.red,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: double.infinity,
                          //width: 150,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topRight: Radius.circular(30)),
                                  ))
                              ),
                              onPressed: (){
                                Get.back();
                              },
                              // icon: Icon(Icons.close_rounded, color: Colors.white, size: 12,),
                              child: Text("No", style: TextStyle(color: Colors.red, fontFamily: 'KiwiRegular', fontSize: 12),)
                          ),
                        ),


                        SizedBox(
                          height: double.infinity,
                          //width: 150,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(mainColor),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), topLeft: Radius.circular(30)),
                                  ))
                              ),
                              onPressed: (){
                                SharedPrefs.instance.clearData();
                                Get.offAll(() => LoginScreen());
                              },

                              child: Text("Yes", style: TextStyle(color: Colors.white, fontFamily: 'KiwiRegular', fontSize: 12),)
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
      ),
    );
  }
}
