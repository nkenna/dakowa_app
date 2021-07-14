import 'package:cached_network_image/cached_network_image.dart';
import 'package:dakowa_app/models/post.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/screens/dashboard/posts/createpostscreen.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    Provider.of<DashBoardProvider>(context, listen: false).userPosts(Provider.of<DashBoardProvider>(context, listen: false).creator!.id!);
  }

  Widget searchField(){
    return SizedBox(
      width: 400,
      height: 40,
      child: TextField(
        controller: searchController,
        style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'KiwiRegular'),
        enableSuggestions: true,
        autocorrect: true,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffe8f0fe),
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
            hintText: "Search here",
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'KiwiRegular')
        ),
        onChanged: (query){
          if(query.isNotEmpty && query.length > 5){
            Provider.of<DashBoardProvider>(context, listen: false).searchPosts(query);
            return;
          }

          if(query.isEmpty){
            Provider.of<DashBoardProvider>(context, listen: false).userPosts(Provider.of<DashBoardProvider>(context, listen: false).creator!.id!);
          }
        },

      ),
    );
  }

  Widget _btnRowWidget(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            searchField(),
            SizedBox(height: 20,),

            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: (){
                  Get.to(() => CreatePostScreen());
               //   showDialog(context: context, builder: (context){
               //     return CreatePostModal();
               //   }
                //  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
                child: Text("Create a Post", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
              ),
            ),
          ],
        )
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
                        width: 60,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff43f6ea),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${Jiffy(p.createdAt).MMM}", style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 14),),
                            Text("${Jiffy(p.createdAt).format('dd')}", style: TextStyle(fontFamily: 'KiwiMedium', fontSize: 18, fontWeight: FontWeight.bold),),
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
                    "${p.content}".capitalizeFirst!,
                    //maxLines: 3,
                    style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 12, color: Colors.black87),
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


                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){

                                  },
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

  Widget _myCreativesListWidget(BuildContext context){
    return Consumer<DashBoardProvider>(
      builder: (context, dProvider, _){
        if(dProvider.posts.isEmpty){
          return Center(
            child: Text("No Posts found. Create a new Post."),
          );
        }
        return ListView.builder(
          itemCount: dProvider.posts.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return _creativeContainerMobile(dProvider.posts[index]);
          },
        );
      },

    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      //color: Colors.brown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: _btnRowWidget(),
          ),

          Expanded(
              child: _myCreativesListWidget(context)
          ),


        ],
      ),
    );
  }
}
