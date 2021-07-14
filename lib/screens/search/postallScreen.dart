import 'package:dakowa_app/models/post.dart';
import 'package:dakowa_app/providers/searchprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsAllScreen extends StatefulWidget {
  @override
  _PostsAllScreenState createState() => _PostsAllScreenState();
}

class _PostsAllScreenState extends State<PostsAllScreen> {

  Widget alteContainer({String? text}){
    return Center(
      child: Text(text!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: Provider.of<SearchProvider>(context, listen: true).futureData,
          builder: (BuildContext context, snapshot){
            print(snapshot.hasData);
            if(snapshot.hasError){
              return alteContainer(text: "Error occurred retrieving data...");
            }
            else if (snapshot.connectionState == ConnectionState.waiting){
              return alteContainer(text: "Loading....");
            }
            else if(snapshot.data == null){
              return alteContainer(text: "No Post found.....");
            }
            else if(snapshot.connectionState == ConnectionState.done){
              return snapshot.hasData == true && snapshot.data!.length == 0 ?
              alteContainer(text: "No Post found.....")
                  : ListView.builder(
                itemCount: snapshot.data!['posts'].length,
                itemBuilder: (context, int i){
                  Post post = snapshot.data!['posts'][i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff7cb32f),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${post.title}", style: TextStyle(color: Colors.white),),
                            Text("${post.username}", style: TextStyle(color: Colors.white, fontSize: 12),),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return alteContainer(text: "No Post found.....");
            }
          },
        )
    );
  }
}
