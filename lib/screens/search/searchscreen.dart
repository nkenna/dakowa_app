import 'package:dakowa_app/screens/search/creatorsallscreen.dart';
import 'package:dakowa_app/screens/search/goalsallscreen.dart';
import 'package:dakowa_app/screens/search/postallScreen.dart';
import 'package:dakowa_app/screens/search/searchfield.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<Widget> _containers = [
    CreatorsAllScreen(),
    GoalsAllScreen(),
    PostsAllScreen()
  ];

  int _container = 0;


  void changeContainer(int i){
    setState(() {
      _container = i;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width,
                  height: 70,
                  child: Container(
                    color: mainColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back_rounded, size: 24, color: Colors.white,),
                          ),

                          SizedBox(width: 20,),

                         SearchFeild(searchController: searchController),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 40,
                  width: Get.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                              onPressed: () => changeContainer(0),
                              icon: Icon(Icons.people_rounded, size: 16,),
                              label: Text("Creators", style: TextStyle(fontSize: 12),)
                        ),
                      ),

                      Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () => changeContainer(1),
                            icon: Icon(Icons.account_tree, size: 16,),
                            label: Text("Goals", style: TextStyle(fontSize: 12),)
                        ),
                      ),


                      Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () => changeContainer(2),
                            icon: Icon(Icons.post_add_rounded),
                            label: Text("Posts", style: TextStyle(fontSize: 12),)
                        ),
                      ),



                    ],
                  ),
                ),

                _containers[_container]


              ],
            ),
          ),
        )
    );
  }
}
