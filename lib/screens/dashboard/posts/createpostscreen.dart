import 'dart:io';

import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController mediaUrlController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  PickedFile? _imageFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  Widget _titleField(){
    return SizedBox(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: titleController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            maxLength: 50,
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

                hintText: "Enter Goal Title",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _contentField(){
    return SizedBox(
        width: double.infinity,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextField(
            controller: contentController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,

            minLines: 10,
            maxLines: 20,
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
                //helperText: "This goal becomes inactive once this amount have been reached irrespective of the end date.",

                hintText: "Enter Goal Description",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: _titleField(),
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: _contentField()
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child:  _imageFile == null
                  ? Container()
                  : Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:FileImage(File(_imageFile!.path))
                        )
                    ),
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: InkWell(
                      onTap: () async{
                        try {
                          final pickedFile = await _picker.getImage(
                            source: ImageSource.gallery,
                            //maxWidth: maxWidth,
                            //maxHeight: maxHeight,
                            imageQuality: 90,
                          );
                          setState(() {
                            _imageFile = pickedFile;
                          });
                        } catch (e) {
                          setState(() {
                            _pickImageError = e;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffe9f0f4),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(8),
                        child: Text(
                            "${_imageFile == null ? "" : p.basename(_imageFile!.path)}"
                        ),
                      ),
                    )
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: ElevatedButton(
                        onPressed: () async{


                          if(_imageFile == null){
                            LoadingControl.showSnackBar(
                                "Ouchs!!!",
                                "Select an image to attach to this post",
                                Icon(Icons.error, color: Colors.red,)
                            );




                            return;
                          }
                          else if(titleController.text.isEmpty){
                            LoadingControl.showSnackBar(
                                "Ouchs!!!",
                                "Post title cannot be empty",
                                Icon(Icons.error, color: Colors.red,)
                            );

                            return;
                          }


                          File(_imageFile!.path).length().then((value) async{
                            if(value > 1000000){
                              LoadingControl.showSnackBar(
                                  "Ouchs!!!",
                                  "Image size cannot exceed 1mb",
                                  Icon(Icons.error, color: Colors.red,)
                              );
                              return;
                            }

                            Provider.of<DashBoardProvider>(context, listen: false).createPost(
                                context,
                                titleController.text,
                                contentController.text,
                                "",
                                Provider.of<DashBoardProvider>(context, listen: false).creator!.username!,
                                Provider.of<DashBoardProvider>(context, listen: false).creator!.id!,
                                "image",
                                await _imageFile!.readAsBytes()
                            // File(null, _imageFile.path, [])
                            );
                          });



                        },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainColor)
                      ),
                      child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'KiwiRegular'),),
                    )
                ),


              ],
            ),
          ),
        )
    );
  }
}
