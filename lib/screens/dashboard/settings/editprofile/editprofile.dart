import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController karfaController = TextEditingController();
  TextEditingController firstAttributeController = TextEditingController();
  TextEditingController secondAttributeController = TextEditingController();
  TextEditingController vidUrlController = TextEditingController();

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    fullNameController.text = Provider.of<DashBoardProvider>(context, listen: false).creator!.name!;
    karfaController.text = "${Provider.of<DashBoardProvider>(context, listen: false).creator!.karfa!}";
    firstAttributeController.text = Provider.of<DashBoardProvider>(context, listen: false).creator!.firstAttribute!;
    secondAttributeController.text = Provider.of<DashBoardProvider>(context, listen: false).creator!.secondAttribute!;
    vidUrlController.text = Provider.of<DashBoardProvider>(context, listen: false).creator!.videoUrl!;

    _controller = YoutubePlayerController(
      initialVideoId: 'tcodrIK2P_I',
      params: YoutubePlayerParams(
        playlist: [

        ],
        startAt: const Duration(minutes: 0, seconds: 0),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: true,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller!.onEnterFullscreen = () {
      //SystemChrome.setPreferredOrientations([
      //  DeviceOrientation.landscapeLeft,
      //  DeviceOrientation.landscapeRight,
      //]);
      print('Entered Fullscreen');
    };
    _controller!.onExitFullscreen = () {
      print('Exited Fullscreen');
    };
  }

  Widget _fullNameField(){
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: fullNameController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onChanged: (value){
              setState(() { });
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

                hintText: "Enter Full Name",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _karfaField(){
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: karfaController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "How much will you receive for a Karfa (NGN)",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _fAttributeField(){
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: firstAttributeController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (value){
              setState(() { });
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

                hintText: "Enter your first Attribute",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _sAttributeField(){
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: secondAttributeController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (value){
              setState(() { });
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

                hintText: "Enter your second Attribute",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _vidUrlField(){
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: vidUrlController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (value){
              if(value != null && value.isNotEmpty){
                var pos = value.lastIndexOf('=');
                if(pos != -1){
                  print(value.substring(pos + 1));
                  _controller!.load(value.substring(pos + 1));
                }
                String result = (pos != -1) ? value.substring(0, pos): vidUrlController.text;
                print(result);

              }
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

                hintText: "Enter Video Url e.g. https://www.youtube.com/watch?v=UsD2hxFgyHA",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }


  Widget _basicInfoWidget(){
    const player = YoutubePlayerIFrame();

    return Container(
      width: 600,
      //height: 300,
      decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _fullNameField(),
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _karfaField()
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("Lets spice your profile. Tell us what you do or who you are. The end result should look like this: ${fullNameController.text} is a ${firstAttributeController.text} and ${secondAttributeController.text}")
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _fAttributeField()
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _sAttributeField()
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("You can use a video to tell your story or highlight what you do. Upload atleast a 5minutes video to Youtube and paste the video link here. The Youtube video should be in this format: https://www.youtube.com/watch?v=UsD2hxFgyHA")
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _vidUrlField()
          ),

          SizedBox(
            width: 300,
            height: 300,
            child: Container(
              child: YoutubePlayerControllerProvider(
                // Passing controller to widgets below.
                controller: _controller!,
                child: player,


              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: (){

                  Provider.of<DashBoardProvider>(context, listen: false).editCreatorProfile(
                      fullNameController.text,
                      Provider.of<DashBoardProvider>(context, listen: false).creator!.username!,
                      double.parse(karfaController.text.isEmpty ? "500" : karfaController.text),
                      firstAttributeController.text,
                      secondAttributeController.text,
                      vidUrlController.text);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
                child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              children: [
                _basicInfoWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
