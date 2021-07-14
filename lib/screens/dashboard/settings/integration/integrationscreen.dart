import 'dart:typed_data';
import 'package:clipboard/clipboard.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class IntegrationScreen extends StatefulWidget {
  @override
  _IntegrationScreenState createState() => _IntegrationScreenState();
}

class _IntegrationScreenState extends State<IntegrationScreen> {
  Uint8List? _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey scr1 = GlobalKey();

  String? _link;
  //print(_link);
  String px = "px";

  String? width;
  String? height;
  String? bkGrdColor;
  String? borderR;
  String? btnText;
  String? txtColor;
  String? padding;
  String? fontSize;

  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bkGrdColorController = TextEditingController();
  TextEditingController txtColorController = TextEditingController();
  TextEditingController paddingController = TextEditingController();
  TextEditingController fontSizeController = TextEditingController();
  TextEditingController borderRController = TextEditingController();

  TextEditingController aController = TextEditingController();



  @override
  void initState() {
    super.initState();
    _link = "https://dakowa.com/${Provider.of<DashBoardProvider>(context, listen: false).creator!.username}";
    width = "250" + px;
    height = "50" + px;
    bkGrdColor = "#000000";
    borderR = "20" + px;
    btnText = "Support me on Dakowa";
    txtColor = "#FF0000";
    padding = "2" + px;
    fontSize = "14" + px;
  }

  Widget _textField(TextEditingController controller, TextInputType tit, String hint){
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextField(
            controller: controller,
            style: TextStyle(fontSize: 14, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: tit,
            textInputAction: TextInputAction.next,
            onChanged: (value){
              setState(() {});
            },

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

                hintText: "${hint}",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _aField(){
    return SizedBox(
        width: double.infinity,
        //height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextField(
            controller: aController,
            style: TextStyle(fontSize: 14, color: Colors.black),
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            minLines: 5,
            maxLines: 7,
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

                hintText: "Click on continue button to get code",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  @override
  Widget build(BuildContext context) {


    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Save the QR code image and share it with your supporters."),
            SizedBox(height: 10,),
            Screenshot(
              key: scr1,
              controller: screenshotController,
              child: QrImage(
                data: _link!,
                version: QrVersions.auto,
                size: 280,
                gapless: false,
                embeddedImage: AssetImage('assets/images/main_logo.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(60, 60),
                ),
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Uh oh! Something went wrong...",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () async{
                  screenshotController.capture().then((image) async{
                    //Capture Done
                    print("captured");

                    if (await Permission.contacts.request().isGranted) {
                      // Either the permission was already granted before or the user just granted it.
                      final result = await ImageGallerySaver.saveImage(
                          image!,
                          quality: 95,
                          name: "dakowa-${DateTime.now().millisecondsSinceEpoch}");
                      print(result);
                    }
                   else if (await Permission.speech.isPermanentlyDenied) {
                      openAppSettings();
                    }


                  }).catchError((onError) {
                    print(onError);
                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
                child: Text("Save your QR Image", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
              ),
            ),

            SizedBox(height: 20,),

            Text("Enter the attributes of your link. "),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: _textField(widthController, TextInputType.number, "Enter Width: (default: ${width}"),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: _textField(heightController, TextInputType.number, "Enter Height: (default: ${height}"),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: _textField(bkGrdColorController, TextInputType.text, "Enter Background color: (default: ${bkGrdColor}"),
            ),

            /*Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: _textField(borderRController, TextInputType.text, "Enter Height: (default: ${borderR}"),
            ), */

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: _textField(txtColorController, TextInputType.text, "Enter Font Color: (default: ${txtColor}"),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: _textField(fontSizeController, TextInputType.number, "Enter Font size: (default: ${fontSize}"),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: _textField(borderRController, TextInputType.number, "Enter Border radius: (default: ${padding}"),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: _aField(),
            ),


            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () async{
                  if(widthController.text.isEmpty){
                    widthController.text = width!;
                  }else{
                    widthController.text = widthController.text + px;
                  }

                  if(heightController.text.isEmpty){
                    heightController.text = height!;
                  }else{
                    heightController.text = heightController.text + px;
                  }

                  if(paddingController.text.isEmpty){
                    paddingController.text = padding!;
                  }else{
                    paddingController.text = paddingController.text + px;
                  }

                  if(fontSizeController.text.isEmpty){
                    fontSizeController.text = fontSize!;
                  }else{
                    fontSizeController.text = fontSizeController.text + px;
                  }

                  if(txtColorController.text.isEmpty){
                    txtColorController.text = txtColor!;
                  }

                  if(bkGrdColorController.text.isEmpty){
                    bkGrdColorController.text = bkGrdColor!;
                  }

                  if(borderRController.text.isEmpty){
                    borderRController.text = fontSize!;
                  }else{
                    borderRController.text = borderRController.text + px;
                  }


                  String aText = "<a " +
                      "href=\"${_link}\" " +
                      "style=\"display: flex; align-items: center; justify-content: center; padding: ${paddingController.text}; font-size: ${fontSizeController.text}; text-decoration: none; color: ${txtColorController.text}; width: ${widthController.text}; height: ${heightController.text}; background-color: ${bkGrdColorController.text}; border-radius: ${borderRController.text}; \""
                          ">" +
                      "<img src=\"https://dakowa.com/main_logo_icon.png\" width=\"40\"> " +
                      "${btnText}" +
                      "<\/a>";
                  print(aText);
                  debugPrint(aText);

                  setState(() {
                    aController.text = aText;
                  });

                  FlutterClipboard.copy('${aText}').then(( value ){
                    print('copied');

                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
                child: Text("Save button", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

