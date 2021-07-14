import 'package:cached_network_image/cached_network_image.dart';
import 'package:dakowa_app/models/followdata.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/screens/landing/followescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FollowersScreen extends StatefulWidget {
  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {

  Widget _followerContainer(Follower follower){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        //color: Colors.red,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ListTile(
            onTap: (){
              var lp =  Provider.of<LandingProvider>(context, listen: false);
              lp.setSelectedFellowerSid(follower);
              print(lp.selectedFollower!.username);
              Get.to(() => FollowDetailScreen());
            },
            contentPadding: EdgeInsets.zero,
            leading: CachedNetworkImage(
              imageUrl: "${follower.avatar}",
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                backgroundImage: imageProvider,
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text("${follower.name!.isEmpty ? "Anonymous" : follower.name}", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold)),
            subtitle: Text("${follower.comments!.length} comments | ${follower.posts!.length} posts | ${follower.followers!.length} followers", style: TextStyle(fontSize: 10, color: Color(0xff0053a7), fontFamily: 'KiwiRegular',)),
            //trailing: _followButton(),
          ),
        ),
      ),
    );
  }

  Widget _followersWidgetList(){
    return Consumer<LandingProvider>(
      builder: (context, aProvider, _){
        if(aProvider.followDatas.length == 0){
          return Center(
            child: Text("No Followers yet. Create more posts and showcase your profile more to attract followers"),
          );
        }else{
          return ListView.builder(
            itemCount: aProvider.followDatas.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              print(aProvider.followDatas[index].follower!.sId);
              return _followerContainer(aProvider.followDatas[index].follower!);
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
            child: Text("People that are following you", style: TextStyle(fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
          ),
          _followersWidgetList(),
        ],
      )
    );
  }
}
