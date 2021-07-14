import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController avatarController = TextEditingController();
  TextEditingController headerController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();

  bool _obscure = true;
  bool _obscureV = true;
  bool _obscureC = true;

  PickedFile? _imageFileAvatar;
  dynamic _pickImageError;
  final ImagePicker _pickerAvatar = ImagePicker();

  PickedFile? _imageFileHeader;
  final ImagePicker _pickerHeader = ImagePicker();


  @override
  void initState() {
    super.initState();
  }

  Widget _currentPasswordField(){
    return SizedBox(
        width: 350,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            obscureText: _obscureC,
            controller: currentPasswordController,
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

                hintText: "Enter Current Password",
                hintStyle: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular',color: Color(0xff0053a7))
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

  Widget _verifyPasswordField(){
    return SizedBox(
        width: 350,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            obscureText: _obscureV,
            controller: verifyPasswordController,
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

                hintText: "Enter Verify Password",
                hintStyle: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular',color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _updateNameRow(BuildContext context){
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: nameController,
            style: TextStyle(fontSize: 14, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,

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

                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Enter your Full Name",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
            ),
          ),
        ),

        SizedBox(width: 20,),
        SizedBox(
          width: 100,
          height: 40,
          child: ElevatedButton(
              onPressed: (){
                if(nameController.text.isNotEmpty){
                  Provider.of<LandingProvider>(context, listen: false).editFollowerName(
                      Provider.of<AuthProvider>(context, listen: false).user!.id!,
                      nameController.text
                  );
                }
              },
              child: Text("save")
          ),
        ),
      ],
    );
  }

  Widget _updateAvatarRow(BuildContext context){
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: avatarController,
            readOnly: true,
            style: TextStyle(fontSize: 14, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            onTap: ()async{
              try {
                final pickedFile = await _pickerAvatar.getImage(
                  source: ImageSource.gallery,
                  //maxWidth: maxWidth,
                  //maxHeight: maxHeight,
                  imageQuality: 90,
                );
                setState(() {
                  _imageFileAvatar = pickedFile;
                  avatarController.text = _imageFileAvatar!.path;
                });
              } catch (e) {
                print(e);
                setState(() {
                  _pickImageError = e;
                });
              }
            },
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


                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Select Image Avatar",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
            ),
          ),
        ),
        SizedBox(width: 20,),

        SizedBox(
          width: 100,
          height: 40,
          child: ElevatedButton(
              onPressed: ()async{
                if(_imageFileAvatar != null){
                  Provider.of<LandingProvider>(context, listen: false).editFollowerAvatar(
                      Provider.of<AuthProvider>(context, listen: false).user!.id!,
                      await _imageFileAvatar!.readAsBytes()

                  );
                }
              },
              child: Text("save")
          ),
        ),
      ],
    );
  }

  Widget _updateHeaderRow(BuildContext context){
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: headerController,
            readOnly: true,
            style: TextStyle(fontSize: 14, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            onTap: ()async{
              try {
                final pickedFile = await _pickerHeader.getImage(
                  source: ImageSource.gallery,
                  //maxWidth: maxWidth,
                  //maxHeight: maxHeight,
                  imageQuality: 90,
                );
                setState(() {
                  _imageFileHeader = pickedFile;
                  headerController.text = _imageFileHeader!.path;
                });
              } catch (e) {
                print(e);
                setState(() {
                  _pickImageError = e;
                });
              }
            },
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


                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Select Header Image",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
            ),
          ),
        ),

        SizedBox(width: 20,),


        SizedBox(
          width: 100,
          height: 40,
          child: ElevatedButton(
              onPressed: () async{
                if(_imageFileHeader != null){
                  Provider.of<LandingProvider>(context, listen: false).editFollowerHeaderImage(
                      Provider.of<AuthProvider>(context, listen: false).user!.id!,
                      await _imageFileHeader!.readAsBytes()

                  );
                }
              },
              child: Text("save")
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: _updateNameRow(context),
            ),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _updateAvatarRow(context)
            ),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _updateHeaderRow(context)
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Divider(height: 3, thickness: 3, indent: 3, endIndent:  3,),
            ),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _currentPasswordField()
            ),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: _passwordField()
            ),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: _verifyPasswordField()
            ),

            SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                  onPressed: (){
                    if(passwordController.text != verifyPasswordController.text){
                      LoadingControl.showSnackBar(
                          "Ouchs!!!",
                          "Password mismatch",
                          Icon(Icons.error_rounded, color: Colors.orange,)
                      );
                      return;
                    }else if(passwordController.text.length < 8){
                      LoadingControl.showSnackBar(
                          "Ouchs!!!",
                          "Password must be greater than 8 characters",
                          Icon(Icons.error_rounded, color: Colors.orange,)
                      );
                      return;
                    }else if(currentPasswordController.text.isEmpty){
                      LoadingControl.showSnackBar(
                          "Ouchs!!!",
                          "Current Password is required",
                          Icon(Icons.error_rounded, color: Colors.orange,)
                      );
                      return;
                    }
                    Provider.of<AuthProvider>(context, listen: false).changePassword(
                    currentPasswordController.text,
                        passwordController.text,
                        Provider.of<AuthProvider>(context, listen: false).user!.id!);
                  },
                  child: Text("save")
              ),
            ),

            SizedBox(height: 150,)
          ],
        ),
      ),
    );
  }
}
