import 'package:cached_network_image/cached_network_image.dart';
import 'package:dakowa_app/models/post.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/screens/landing/followersscreen.dart';
import 'package:dakowa_app/screens/landing/followescreen.dart';
import 'package:dakowa_app/utils/dataholder.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<TextEditingController> _textEditors1 = [];
  List<TextEditingController> _textEditors2 = [];
  EasyRefreshController _controller = EasyRefreshController();

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

  Widget _creatorsHolderMobile(List<User> crs) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Creators you might fancy", style: TextStyle(color: Colors.black87, fontFamily: 'KiwiMedium', fontSize: 14, fontWeight: FontWeight.w900),),
          ),
          SizedBox(height: 5,),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:  ListView.builder(
                  itemCount: crs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int i){
                    return _creatorsHolderMobileContainer(crs[i]);
                  }
              ),
            )
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : print( 'Could not launch $url');

  Widget _creativeContainerMobile(Post p, TextEditingController controller){
    print("XXXXXXXXXXXXXXXXXXX");
    print(p.likes);
    List<Comments>? ccs = p.comments!.length > 2
    ? p.comments!.sublist(0, 2)
        : p.comments;

    String _url = DataHolder.extractLink(p.content!);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      child: InkWell(
                        onTap: (){
                          var lp =  Provider.of<LandingProvider>(context, listen: false);
                          lp.setSelectedFellowerSid(p.owner);
                          Get.to(() => FollowDetailScreen());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${p.title ?? ""}".toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontFamily: 'KiwiMedium', fontSize: 14, fontWeight: FontWeight.bold),),
                            Text("${p.owner!.username}".capitalizeFirst!,//"Thu 10:00 AM",
                              style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 12,),),
                            Text("${Jiffy(p.createdAt).jm}",//"Thu 10:00 AM",
                              style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 12,),),

                          ],
                        ),
                      ),
                    ),

               /*     InkWell(
                      onTap: (){},
                      child: Icon(Icons.drag_indicator_rounded, color: Color(0xffc4c4c4),),
                    ), */
                  ],
                )
            ),

            Container(
              //height: 90,
              width: double.infinity,
              child: Container(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    "${p.content}",
                    //maxLines: 3,
                    style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 12, color: Colors.black54)// color: Color(0xffc4c4c4)),
                  ),
                ),
              ),
            ),

            _url != null &&  _url.isNotEmpty

            ? SimpleUrlPreview(
              url: _url,
              bgColor: Color(0xfff9f9f9),
              isClosable: true,
              titleLines: 2,
              descriptionLines: 3,
              imageLoaderColor: mainColor,
              previewHeight: 180,
              previewContainerPadding: EdgeInsets.all(10),
              onTap: () {
                print('Hello Flutter URL Preview: ${_url}');
                _launchURL(_url);
              },
              titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'KiwiMedium'
              ),
              descriptionStyle: TextStyle(
                fontSize: 12,
                  color: Colors.black54,
                  fontFamily: 'KiwiRegular'
              ),
              siteNameStyle: TextStyle(
                fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'KiwiMedium'
              ),
            )
            : Container(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: "${p.mediaUrl![0]}",
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    //color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 8, right: 2),
                                    child: Text("${p.comments!.length}", style: TextStyle(color: Color(0xff0053a7), fontSize: 12, fontFamily: 'KiwiRegular'),)
                                ),

                                InkWell(
                                  onTap: (){
                                    //Provider.of<AuthProvider>(context, listen: false).setSelectedPost(p);
                                    //showDialog(context: context,
                                    //    builder: (context) {
                                    //      return CreateCommentMobile();
                                    //    }
                                    //);
                                  },
                                  child: Icon(Icons.messenger_outline_rounded, color: Color(0xff0053a7), size: 16,),
                                ),

                                //Text("Comments", style: TextStyle(color: Color(0xff0053a7), fontSize: 12, fontFamily: 'KiwiRegular'),),
                              ],
                            ),

                            InkWell(
                              onTap: (){
                                Share.share("${p.content}", subject: "${p.title!}");
                              },
                              child: Icon(Icons.share_rounded, color: Color(0xffc4c4c4), size: 16,),
                            ),

                           /* InkWell(
                              onTap: (){
                                Provider.of<LandingProvider>(context, listen: false).playAudio();
                                Provider.of<LandingProvider>(context, listen: false).likePost(
                                    Provider.of<AuthProvider>(context, listen: false).user!.id!,
                                    p.id!
                                );
                              },
                              child: FutureBuilder<bool>(
                                future: Provider.of<LandingProvider>(context, listen: true).checkLike(p.likes!, Provider.of<AuthProvider>(context, listen: false).user!.id!),
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    return Icon(
                                      Icons.thumb_up,
                                      color: snapshot.data!
                                          ? Colors.redAccent
                                          : Color(0xffc4c4c4),
                                      size: 16,);
                                  }else{
                                    return Container();
                                  }

                                },
                              ),
                            ), */

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: List.generate(ccs!.length, (index){
                return ListTile(
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.zero,
                  leading: CachedNetworkImage(
                    imageUrl: "${ccs[index].commenter!.avatar}",
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      backgroundImage: imageProvider,
                    ),
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                 // isThreeLine: true,

                  title: Text("${ccs[index].commenter!.name!.isEmpty ? "Anonymous" : ccs[index].commenter!.name}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'KiwiMedium')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${ccs[index].content}", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular')),
                      SizedBox(height: 5,),
                      //Text("${ccs[index].replies!.length} replies", style: TextStyle(color: Color(0xff0053a7), fontSize: 12, fontFamily: 'KiwiRegular'),),
                     // SizedBox(height: 5,),


                    ],
                  ),

                  trailing: Text("${Jiffy(ccs[index].createdAt).fromNow()}", style: TextStyle(fontSize: 12, color: Colors.black38, fontFamily: 'KiwiRegular')),
                  //trailing: Text("09:10 PM", style: TextStyle(fontSize: 12, color: Colors.black12, fontFamily: 'KiwiRegular')),
                );
              }

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: "${Provider.of<AuthProvider>(context, listen: false).user!.avatar!}",
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 15,

                    ),
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(width: 5,),

                  Expanded(
                      child: TextField(
                        controller: controller,
                        style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Colors.black),
                        enableSuggestions: true,
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.send,
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
                            //prefixIcon: Icon(Icons.email_rounded, color: Colors.grey, size: 16,),
                            floatingLabelBehavior: FloatingLabelBehavior.never,

                            hintText: "Write a comment",
                            hintStyle: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Color(0xff0053a7))
                        ),
                      )
                  ),
                  SizedBox(width: 5,),

                  InkWell(
                    onTap: ()async {
                      Provider.of<LandingProvider>(context, listen: false).setSelectedPost(p);
                      final resp = await Provider.of<LandingProvider>(context, listen: false).createComment(
                          controller.text,
                          Provider.of<AuthProvider>(context, listen: false).user!.id!,
                          Provider.of<LandingProvider>(context, listen: false).selectedPost!.userId!,
                          Provider.of<LandingProvider>(context, listen: false).selectedPost!.id!,
                          false,
                          "",
                          //Provider.of<AuthProvider>(context, listen: false).selectedComment.sId,
                          context);
                      if(resp){
                        p.comments = Provider.of<LandingProvider>(context, listen: false).selectedPost!.comments;
                        setState(() {});
                      }
                      controller.clear();
                    },
                    child: Provider.of<LandingProvider>(context, listen: true).commentLoading
                    ? CircularProgressIndicator.adaptive()
                    : Icon(Icons.send_rounded, color: mainColor,),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  /*Widget _myCreativesListWidget(List<Post> ps){
    return ListView.builder(
      itemCount: ps.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return _creativeContainerMobile(ps[index]);
      },
    );
  }*/

  Widget _myCreativesListWidget1(List<Post> ps){
    return Column(
      children: List.generate(ps.length, (index) {
        _textEditors1 = List.generate(ps.length, (j) => TextEditingController());
        return  _creativeContainerMobile(ps[index], _textEditors1[index]);
      }),
    );
  }

  Widget _myCreativesListWidget2(List<Post> ps){
    return Column(
      children: List.generate(ps.length, (index) {
        _textEditors2 = List.generate(ps.length, (j) => TextEditingController());
        return  _creativeContainerMobile(ps[index], _textEditors2[index]);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: EasyRefresh(
        onRefresh: () async{
          await Provider.of<AuthProvider>(context, listen: false).retrieveUser();
          Provider.of<LandingProvider>(context, listen: false).userProfileExplore(Provider.of<AuthProvider>(context, listen: false).user!.id!);
          Provider.of<LandingProvider>(context, listen: false).userExplorePosts(Provider.of<AuthProvider>(context, listen: false).user!.id!);
          Provider.of<LandingProvider>(context, listen: false).userExplorePosts(Provider.of<AuthProvider>(context, listen: false).user!.id!);
          Provider.of<LandingProvider>(context, listen: false).exploreCreators("creator", Provider.of<AuthProvider>(context, listen: false).user!.id!);
          Provider.of<LandingProvider>(context, listen: false).userFollowers(Provider.of<AuthProvider>(context, listen: false).user!.id!);
          Provider.of<LandingProvider>(context, listen: false).userFollowing(Provider.of<AuthProvider>(context, listen: false).user!.id!);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Provider.of<LandingProvider>(context, listen: true).creators1.isNotEmpty
              ? _creatorsHolderMobile(Provider.of<LandingProvider>(context, listen: false).creators1)
              : Container(),

              Provider.of<LandingProvider>(context, listen: true).posts1.isNotEmpty
              ? _myCreativesListWidget1(Provider.of<LandingProvider>(context, listen: false).posts1)
              : Container(),

              Provider.of<LandingProvider>(context, listen: true).creators2.isNotEmpty
              ? _creatorsHolderMobile(Provider.of<LandingProvider>(context, listen: false).creators2)
              : Container(),

              Provider.of<LandingProvider>(context, listen: true).posts2.isNotEmpty
              ? _myCreativesListWidget2(Provider.of<LandingProvider>(context, listen: false).posts2)
              : Container(),

              SizedBox(height: 100,),

            ],
          ),
        ),
      ),
    );
  }
}
