import 'package:cached_network_image/cached_network_image.dart';
import 'package:dakowa_app/models/followdata.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/screens/landing/followescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {


  Widget _followingContainer(Following following){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        //color: Colors.red,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ListTile(
            onTap: (){
              var lp =  Provider.of<LandingProvider>(context, listen: false);
              lp.setSelectedFellowerSid(following);
              print(lp.selectedFollower!.name);
              Get.to(() => FollowDetailScreen());

            },
            contentPadding: EdgeInsets.zero,
            leading: CachedNetworkImage(
              imageUrl: "${following.avatar}",
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                backgroundImage: imageProvider,
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text("${following.name!.isEmpty ? "Anonymous" : following.name}", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold)),
            subtitle: Text("${following.comments!.length} comments | ${following.posts!.length} posts | ${following.followers!.length} followers", style: TextStyle(fontSize: 10, color: Color(0xff0053a7), fontFamily: 'KiwiRegular',)),
            //trailing: _followButton(),
          ),
        ),
      ),
    );
  }

  Widget _followersWidgetList(){
    return Consumer<LandingProvider>(
      builder: (context, aProvider, _){
        if(aProvider.followingDatas.length == 0){
          return Center(
            child: Text("You are not following anybody yet. Follow more to make your page lively"),
          );
        }else{
          return ListView.builder(
            itemCount: aProvider.followingDatas.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return _followingContainer(aProvider.followingDatas[index].following!);
            },
          );
        }
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("People you are following", style: TextStyle(fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
            ),
            _followersWidgetList(),
          ],
        )
    );
  }
}
