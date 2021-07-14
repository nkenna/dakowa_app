import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class CreateUserModal extends StatefulWidget {
  BuildContext? ctx;

  CreateUserModal({this.ctx});

  @override
  _CreateUserModalState createState() => _CreateUserModalState();
}

class _CreateUserModalState extends State<CreateUserModal> {
  TextEditingController usernameController = TextEditingController();


  Widget _replyField(){
    return SizedBox(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: usernameController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            //minLines: 3,
            //maxLines: 5,
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
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  @override
  Widget build(BuildContext context) {
    var aProvider = Provider.of<AuthProvider>(context, listen: false);

    return Center(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: SizedBox(
          width: Get.width * 0.8,
          height: 300,
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
                            "Create your Page",
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
                                Navigator.of(context).pop();
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
                              child: Text(
                                "Seems you do not have a page yet. Create a page by adding a username to your account.",
                                style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              child: _replyField(),
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
                                Navigator.of(context).pop();
                              },
                              // icon: Icon(Icons.close_rounded, color: Colors.white, size: 12,),
                              child: Text("Cancel", style: TextStyle(color: Colors.red, fontFamily: 'KiwiRegular', fontSize: 12),)
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
                              onPressed: () async{
                                //print(Provider.of<AuthProvider>(context, listen: false).selectedComment.sId);

                                final resp =  await Provider.of<LandingProvider>(context, listen: false).checkUsername(usernameController.text);

                                print(resp);
                                if(resp){
                                  await Provider.of<LandingProvider>(context, listen: false).upgradeToCreator(
                                    usernameController.text,
                                      Provider.of<AuthProvider>(context, listen: false).user!.id!
                                  );
                                }
                                usernameController.clear();
                                Navigator.of(context).pop();
                              },

                              child: Text("Continue", style: TextStyle(color: Colors.white, fontFamily: 'KiwiRegular', fontSize: 12),)
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
