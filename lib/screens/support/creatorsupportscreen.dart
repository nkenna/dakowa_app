import 'package:cached_network_image/cached_network_image.dart';
import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/providers/supportprovider.dart';
import 'package:dakowa_app/screens/auth/loginscreen.dart';
import 'package:dakowa_app/screens/landing/landingscreen.dart';
import 'package:dakowa_app/utils/dataholder.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CreatorScreenScreen extends StatefulWidget {
  final String? username;

  CreatorScreenScreen({this.username});

  @override
  _CreatorScreenScreenState createState() => _CreatorScreenScreenState();
}

class _CreatorScreenScreenState extends State<CreatorScreenScreen> {

  String? txRef;
  Size? size;
  ScrollController? _scrollController;
  bool _isAnonymous = false;

  TextEditingController qtyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noteController = TextEditingController();


  double totalAmount = 0;
  final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: DataHolder.PAYSTACK_PUBLIC_LIVE_KEY);


    Provider.of<SupportProvider>(context, listen: false).creatorProfile(widget.username!);
    Provider.of<SupportProvider>(context, listen: false).setYT(
        YoutubePlayerController(
          initialVideoId: '',
          params: const YoutubePlayerParams(
            playlist: [],
            startAt: const Duration(minutes: 1, seconds: 36),
            showControls: true,
            showFullscreenButton: true,
            desktopMode: true,
            privacyEnhanced: true,
            useHybridComposition: true,
          ),
        )
    );

  }

  @override
  void dispose() {
    Provider.of<SupportProvider>(context, listen: false).closeYT();
    super.dispose();
  }

  String? generateTxRef(){
    txRef =  "ato-${DateTime.now().millisecondsSinceEpoch.toString()}";
    return txRef;
  }

  Widget headerImageContainer(){
    var aProvider = Provider.of<SupportProvider>(context, listen: true);
    return SizedBox(
      width: Get.width,
      height: 150,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "${aProvider.creator!.headerImage}",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: imageProvider
                ),
                color: mainColor,
                //borderRadius: BorderRadius.all(Radius.circular(15))
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),

          Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: "${aProvider.creator!.avatar}",
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                backgroundImage: imageProvider,
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          )

        ],
      ),

    );
  }

  Widget headerProfileInfo(){
    var aProvider = Provider.of<SupportProvider>(context, listen: true);
    return SizedBox(
      width: Get.width,
      child: Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [



                //SizedBox(height: 20),

                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "${aProvider.creator!.name!.isEmpty ? "" : aProvider.creator!.name} ".capitalizeFirst,
                              style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                              children: [
                                TextSpan(
                                  text: "is a ${aProvider.creator!.firstAttribute} and ${aProvider.creator!.secondAttribute}",
                                  style: TextStyle(fontFamily: 'KiwiRegular', color: Colors.black, fontSize: 16),
                                )
                              ]
                          )
                      ),

                      Text(
                        "${aProvider.creator!.supporters!.length} supporters",
                        style: TextStyle(fontFamily: 'KiwiRegular', color: Colors.black38, fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }


  Widget _checkAnonymous(){
    return CheckboxListTile(
      title: Text("Support Annoymously", style: TextStyle(fontFamily: 'KiwiRegular', color: Colors.black, fontSize: 14),),
      value: _isAnonymous,
      activeColor: mainColor,

      onChanged: (value){
        setState(() {
          _isAnonymous = value!;
        });
      },

    );
  }

  Widget qtyField(){
    var aProvider = Provider.of<SupportProvider>(context, listen: true);
    return SizedBox(
        width: 200,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: qtyController,
            style: TextStyle(fontSize: 14, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,

            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffe9f0f4),
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Karfa Quantity (default is one)",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
            ),

            onChanged: (value){
              if(value != null && value.isNotEmpty){
                setState((){
                  totalAmount =  aProvider.creator!.karfa! * (double.parse(value.isEmpty ? "0" : value));
                });
              }
            },
          ),
        )

    );

  }

  Widget nameField(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: TextField(
          controller: nameController,
          style: TextStyle(fontSize: 14, color: Colors.black),
          enableSuggestions: true,
          autocorrect: true,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,

          decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xffe9f0f4),
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),

              floatingLabelBehavior: FloatingLabelBehavior.never,

              hintText: "Name (optional)",
              hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
          ),
        ),


      ),
    );

  }

  Widget emailField(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 60,
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
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),

              floatingLabelBehavior: FloatingLabelBehavior.never,

              hintText: "Email Address",
              hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
          ),
        ),


      ),
    );

  }

  Widget noteField(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        //height: 60,
        child: TextField(
          controller: noteController,
          style: TextStyle(fontSize: 14, color: Colors.black),
          minLines: 10,
          maxLines: 20,
          enableSuggestions: true,
          autocorrect: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.none,

          decoration: InputDecoration(
              filled: true,
              //contentPadding: EdgeInsets.only(top: 10),
              fillColor: Color(0xffe9f0f4),
              contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),

              floatingLabelBehavior: FloatingLabelBehavior.never,

              hintText: "Add a short note",
              hintStyle: TextStyle(fontSize: 14, color: Color(0xff0053a7))
          ),
        ),


      ),
    );

  }

  Widget supportBtn(){
    var aProvider = Provider.of<SupportProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(mainColor),

              ),
              onPressed: () async{
                if(emailController.text.isEmpty){
                  LoadingControl.showSnackBar(
                      "Ouchs!!!",
                      "Your email is required.",
                      Icon(Icons.error, color: Colors.red,)
                  );

                  return;
                }
                totalAmount = totalAmount == 0.0
                    ? Provider.of<SupportProvider>(context, listen: false).creator!.karfa!
                    : totalAmount;

                Charge charge = Charge()
                  ..amount = (totalAmount * 100).toInt()
                  ..reference = generateTxRef()
                  ..email = emailController.text;



                final response = await plugin.checkout(
                  
                  context,
                  logo: Image.asset("assets/images/main_logo.png", width: 50,),
                  method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
                  charge: charge,
                  hideEmail: true
                );

                //final response =  await PaystackClient.checkout(context, charge: charge);

                print(response);

                if(response.status){
                  print("it got here");
                  Provider.of<SupportProvider>(context, listen: false).creatorSupport(context,
                      charge.reference!,
                      emailController.text,
                      nameController.text,
                      noteController.text,
                      _isAnonymous,
                      int.tryParse(qtyController.text.isEmpty ? "1" : qtyController.text)!,
                      widget.username!);

                }else{
                  LoadingControl.showSnackBar(
                      "Ouchs!!!",
                      "${response.message}",
                      Icon(Icons.error, color: Colors.red,)
                  );

                }





              },
              child: Text("Support with NGN ${totalAmount}",
                style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
              )
          )

      ),
    );

  }

  Widget seemoreBtn(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
          width: 200,
          height: 40,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff3bf4f7)),

              ),
              onPressed: (){
                Provider.of<SupportProvider>(context, listen: false).setSupportersLength(
                    Provider.of<SupportProvider>(context, listen: false).supporters.length
                );

              },
              child: Text("See More",
                style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
              )
          )

      ),
    );

  }

  Widget _supportBox(){
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xfffff9f4),
            border: Border.all(color: mainColor),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.wallet_giftcard_rounded, color: Color(0xff0053a7)),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("X"),
            ),
            qtyField()

          ],
        ),
      ),
    );
  }


  Widget mainWidget(){
    const player = YoutubePlayerIFrame();

    return SizedBox(
      width: Get.width,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: double.infinity,
                //height: 300,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _checkAnonymous(),
                        _supportBox(),
                        SizedBox(height: 10,),
                        nameField(),
                        emailField(),
                        noteField(),
                        supportBtn(),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              SizedBox(
                width: double.infinity,
                height: 300,
                child: Container(
                  child: YoutubePlayerControllerProvider(
                    // Passing controller to widgets below.
                    controller: Provider.of<SupportProvider>(context, listen: true).controller!,
                    child: player,


                  ),
                ),
              ),
            ],
          )
      ),

    );
  }

  Widget _supportersBox(){
    var aProvider = Provider.of<SupportProvider>(context, listen: true);
    return SizedBox(
      width: Get.width,
      //height: ,
      child: Container(

          child: Column(
            children: List.generate(
                aProvider.supporters.length,
                    (index) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: ListTile(
                          //isThreeLine: true,
                          contentPadding: EdgeInsets.zero,
                          leading: CachedNetworkImage(
                            imageUrl: "${aProvider.supporters[index].avatar}",
                            imageBuilder: (context, imageProvider) => CircleAvatar(
                              radius: 30,
                              backgroundImage: imageProvider,

                            ),
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          title: RichText(
                              text: TextSpan(
                                  text: "${aProvider.supporters[index].name} ".capitalizeFirst,
                                  style: TextStyle( color: Colors.black, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: "bought ${aProvider.supporters[index].quantity} karfas",
                                      style: TextStyle(fontSize: 14, fontFamily: 'KiwiRegular', fontWeight: FontWeight.normal),
                                    )
                                  ]
                              )
                          ),
                          subtitle: Container(
                            decoration: BoxDecoration(

                            ),
                            child: Text("${aProvider.supporters[index].supports![0].note}"),
                          ),
                          trailing: InkWell(
                            onTap: (){
                              String noteShare = aProvider.supporters[index].supports![0].note != null && aProvider.supporters[index].supports![0].note!.isNotEmpty
                                  ? "${aProvider.supporters[index].name} also left this note after supporting: ${aProvider.supporters[index].supports![0].note}"
                                  : "";

                              String shareText = "${aProvider.supporters[index].name} supported ${widget.username} with ${aProvider.supporters[index].quantity} karfas. \n" +
                                  noteShare + " .You too can support ${widget.username} using this link https://explore.dakowa.com/${widget.username} \n #dakowa #${widget.username}";

                              Share.share(shareText);

                             /* showDialog(
                                  context: context,
                                  builder: (context){
                                    return CreatorShareModal(shareText: shareText);
                                  }
                              ); */
                            },
                            child: Icon(Icons.share_rounded, color: Color(0xff0053a7), size: 20,),
                          ),
                        ),
                      ),
                    )
            ),
          )
      ),
    );
  }



  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : print( 'Could not launch $url');

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    //Provider.of<SupportProvider>(context, listen: false).setBuildContext(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            if(Provider.of<AuthProvider>(context, listen: false).user != null){
              Get.offAll(() => LandingScreen());
            }else{
              Get.offAll(() => LoginScreen());
            }
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(widget.username!),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: (){
                String shareText = "${widget.username} is a ${Provider.of<SupportProvider>(context, listen: false).creator!.firstAttribute} and ${Provider.of<SupportProvider>(context, listen: false).creator!.secondAttribute}. "
                    + "I do support ${widget.username} through @dakowa on dakowa.com. You too can also support. You can check out his page on https://explore.dakowa.com/${widget.username} \n #dakowa #${widget.username} @ngdakowa";

                Share.share("${shareText}");
              },
              child: Icon(Icons.share_rounded, size: 20,),
            ),
          )
        ],
      ),
      body: Scrollbar(
          controller: _scrollController,
          child: Provider.of<SupportProvider>(context, listen: true).validUser
              ? SingleChildScrollView(
            //controller: controller,
              child: Column(
                children: [
                  //topbar(size: size),
                 // MainMenu(),

                  headerImageContainer(),
                  headerProfileInfo(),
                  mainWidget(),

                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Recent Supporters", style: TextStyle(fontFamily: 'KiwiMedium', color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 14),),
                        ],
                      ),
                    ),
                  ),

                  _supportersBox(),
                  Provider.of<SupportProvider>(context, listen: true).supporters.length == Provider.of<SupportProvider>(context, listen: true).supportersLength
                      ? Container()
                      : seemoreBtn(),

                ],
              )

          )
              : SizedBox(
            height: Get.height,
            width: Get.width,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("It seems this creator does not yet exist. Check if the Creator name is valid or refresh this page."),
              ),
            ),
          )
      ),
    );
    /*
    Container(
      color: Colors.yellow,
      child: ElevatedButton(
        onPressed: () async{
          print(makePayment(
            "${DateTime.now().millisecondsSinceEpoch}",
            550,
            CustomerDetails(
              name: "Obison",
              email: "obison@gmail.com",
              phone_number: "08139059856"
            ),
            false,
            3,
            "obi",
            allowInterop(() => testFunc())
          ));
          //print(test("check out ") + "ccccc");
          //js.context.callMethod('alertMessage', ['flutter with JS']);
        },
        child: Text("Test Flutterwave")),
    );
  */
  }
}
