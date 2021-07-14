import 'package:cached_network_image/cached_network_image.dart';
import 'package:dakowa_app/models/post.dart';
import 'package:dakowa_app/models/supporter.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/screens/support/creatorsupportscreen.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowDetailScreen extends StatefulWidget {
  @override
  _FollowDetailScreenState createState() => _FollowDetailScreenState();
}

class _FollowDetailScreenState extends State<FollowDetailScreen> {

  @override
  void initState() {
    super.initState();
    if(Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username != null
      && Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username!.isNotEmpty){
      Provider.of<LandingProvider>(context, listen: false).userSupporters(Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username!);
    }else{

    }


    }




  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : print( 'Could not launch $url');

  Widget profileHeader() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Container(
       // color: Colors.red,
        child: Consumer<LandingProvider>(
          builder: (context, aProvider, _){
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: CachedNetworkImage(
                      imageUrl: "${aProvider.selectedFollower!.headerImage == null ? "" :  aProvider.selectedFollower!.headerImage}",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: imageProvider
                            ),
                            color: mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                      ),
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),


                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CachedNetworkImage(
                        imageUrl: "${aProvider.selectedFollower!.avatar}",
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.green,
                          backgroundImage: imageProvider,
                        ),
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),

                      Text(
                        "${aProvider.selectedFollower!.name!.isEmpty ? "Anonymous" : aProvider.selectedFollower!.name} ${aProvider.selectedFollower!.username!.isEmpty ? "" : "-"} ${aProvider.selectedFollower!.username!.isEmpty ? "" : aProvider.selectedFollower!.username}",
                        style: TextStyle(fontSize: 12, color: Color(0xff0053a7), fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 20,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor.withAlpha(200)
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 16,),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },

        ),
      ),

    );
  }

  Widget _buttonRow() {
    bool isFollow = Provider.of<LandingProvider>(context, listen: true).checkFollowing(
        Provider.of<LandingProvider>(context, listen: false).selectedFollower!.id!,
      Provider.of<AuthProvider>(context, listen: false).user!
    );

    print(isFollow);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isFollow
            ? SizedBox(
            width: 120,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(mainColor),
                ),
                onPressed: () async {
                  final resp = await Provider.of<LandingProvider>(context, listen: false).unFollowUser(
                      Provider.of<LandingProvider>(context, listen: false).selectedFollower!.id!,
                      Provider.of<AuthProvider>(context, listen: false).user!.id!
                  );

                  print(Provider.of<LandingProvider>(context, listen: false).selectedFollower!.email!);

                  if(resp){
                    FirebaseMessaging.instance.unsubscribeFromTopic(Provider.of<LandingProvider>(context, listen: false).selectedFollower!.id!);
                    setState(() {
                      isFollow = false;
                    });
                  }

                },
                child: Text("UnFollow", style: TextStyle(fontFamily: 'KiwiMedium', color: Colors.white, fontSize: 10)
                ),
              ),
            )
        )
            : SizedBox(
            width: 150,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(mainColor),

                ),
                onPressed: () async{
                 final resp = await Provider.of<LandingProvider>(context, listen: false).followUser(
                      Provider.of<LandingProvider>(context, listen: false).selectedFollower!.id!,
                      Provider.of<AuthProvider>(context, listen: false).user!.id!
                 );
                 print(Provider.of<LandingProvider>(context, listen: false).selectedFollower!.id);

                 if(resp){
                   FirebaseMessaging.instance.subscribeToTopic(Provider.of<LandingProvider>(context, listen: false).selectedFollower!.id!);
                   setState(() {
                     isFollow = true;
                   });
                 }

                },
                child: Text("Follow", style: TextStyle(fontFamily: 'KiwiMedium', color: Colors.white, fontSize: 10)
                ),
              ),
            )
        ),

       /* isFollow
            ? SizedBox(
            width: 120,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(mainColor),

                ),
                onPressed: (){},
                child: Text("Message", style: TextStyle(fontFamily: 'KiwiMedium', color: Colors.white, fontSize: 10)
                ),
              ),
            )
        )
            : Container(), */

        Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username!.isNotEmpty
            ? SizedBox(
            width: 120,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff7cb32f)),
                ),
                onPressed: (){
                  //_launchURL("https://explore.dakowa.com/${Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username}");
                  Get.to(() => CreatorScreenScreen(username: Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username));
                },
                child: Text("Support", style: TextStyle(fontFamily: 'KiwiMedium', color: Colors.white, fontSize: 10)
                ),
              ),
            )
        )
            : Container()

      ],
    );
  }

  Widget _creativeContainerMobile(Post p){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        width: double.infinity,
        //height: 280,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 75,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff43f6ea),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${Jiffy(p.createdAt).MMM}", style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 12),),
                            Text("${Jiffy(p.createdAt).format('dd')}", style: TextStyle(fontFamily: 'KiwiMedium', fontSize: 16, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${p.title ?? ""}".toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontFamily: 'KiwiMedium', fontSize: 14, fontWeight: FontWeight.bold),),
                          Text("${Jiffy(p.createdAt).jm}",//"Thu 10:00 AM",
                            style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 12,),),

                        ],
                      ),
                    ),

                    InkWell(
                      onTap: (){},
                      child: Icon(Icons.drag_indicator_rounded, color: Color(0xffc4c4c4),),
                    ),
                  ],
                )
            ),

            Container(
              //height: 90,
              width: double.infinity,
              child: Container(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "${p.content}",
                      //maxLines: 3,
                      style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 12, color: Colors.black54)// color: Color(0xffc4c4c4)),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: "${p.mediaUrl![0]}",
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    //color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider
                      )
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    //height: 50,
                    width: double.infinity,
                    child: Container(
                      //color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(

                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 8, right: 2),
                                    child: Text("${p.comments!.length}", style: TextStyle(color: Color(0xff0053a7), fontSize: 12, fontFamily: 'KiwiRegular'),)
                                ),

                                Text("Comments", style: TextStyle(color: Color(0xff0053a7), fontSize: 12, fontFamily: 'KiwiRegular'),),
                              ],
                            ),


                            Row(
                              children: [

                                InkWell(
                                  onTap: (){
                                    //Provider.of<AuthProvider>(context, listen: false).setSelectedPost(p);
                                    //showDialog(context: context,
                                    //    builder: (context) {
                                    //      return CreateCommentMobile();
                                    //    }
                                    //);
                                  },
                                  child: Icon(Icons.visibility, color: Color(0xff0053a7)),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){},
                                  child: Icon(Icons.share_rounded, color: Color(0xffc4c4c4),),
                                ),
                              ],
                            )



                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _myCreativesListWidget(List<Post> ps){
    return Column(
      children: List.generate(ps.length, (index) => _creativeContainerMobile(ps[index])),
    );
  }

  Widget _mySupportersListWidget(){
    if(Provider.of<LandingProvider>(context, listen: true).supporters.isEmpty){
      return Center(
        child: Text(
          "No Supporters yet",
          style: TextStyle(fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: Provider.of<LandingProvider>(context, listen: true).supporters.length,
      itemBuilder: (BuildContext context, int i){
        Supporter supp = Provider.of<LandingProvider>(context, listen: true).supporters[i];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            //width: double.infinity,
            //height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: "${supp.avatar}",
                    imageBuilder: (context, imageProvider) => Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        //color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider
                          )
                      ),
                    ),
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                      child: Text(
                        "${supp.name} supported with ${supp.quantity} ${supp.quantity! > 1 ? "KARFAS" : "KARFA"} on ${Jiffy(supp.createdAt).yMMMEd}",
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular'),
                      )
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

  }

  Widget _creatorsHolderMobileContainer(User cr){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: InkWell(
        onTap: (){
          var lp =  Provider.of<LandingProvider>(context, listen: false);
          lp.setSelectedFellowerId(cr);
          Get.to(() => FollowDetailScreen());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: "${cr.avatar}",
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                backgroundImage: imageProvider,
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 5,),

            Text("${cr.username}", style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular'),)
          ],
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
            
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileHeader(),
                SizedBox(height: 10,),
                _buttonRow(),
                SizedBox(height: 10,),
                Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username != null
                    && Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
                        child: Text("Recent Supporters", style: TextStyle( fontWeight: FontWeight.w900, color: Colors.black87, fontFamily: 'KiwiMedium', fontSize: 14),),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
                        child: Text("Creators you might fancy", style: TextStyle( fontWeight: FontWeight.w900, color: Colors.black87, fontFamily: 'KiwiMedium', fontSize: 14),),
                      ),

                Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username != null
                    && Provider.of<LandingProvider>(context, listen: false).selectedFollower!.username!.isNotEmpty
                ? Expanded(
                    child: _mySupportersListWidget()
                )
                : Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    children: List.generate(Provider.of<LandingProvider>(context, listen: true).creators.length, (index) =>
                        _creatorsHolderMobileContainer(Provider.of<LandingProvider>(context, listen: true).creators[index])
                    ),
                  ),
                ),

                //_myCreativesListWidget(Provider.of<LandingProvider>(context, listen: false).posts)
              ],
            ),


      ),
    );
  }


}
