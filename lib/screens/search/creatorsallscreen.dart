import 'package:cached_network_image/cached_network_image.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/providers/searchprovider.dart';
import 'package:dakowa_app/screens/landing/followescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreatorsAllScreen extends StatefulWidget {
  @override
  _CreatorsAllScreenState createState() => _CreatorsAllScreenState();
}

class _CreatorsAllScreenState extends State<CreatorsAllScreen> {

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
    return Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            shrinkWrap: true,
            itemCount: Provider.of<SearchProvider>(context, listen: true).creators.length,
            itemBuilder: (BuildContext context, i){
              if(Provider.of<SearchProvider>(context, listen: true).creators.length == 0){
                return Center(child: Text("No data found"),);
              }
              return _creatorsHolderMobileContainer(Provider.of<SearchProvider>(context, listen: true).creators[i]);
            }



        ),
    );
  }
}
