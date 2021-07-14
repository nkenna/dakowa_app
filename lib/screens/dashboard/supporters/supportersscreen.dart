import 'package:dakowa_app/models/supporter.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/screens/dashboard/supporters/supportersendmessage.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Supportersscreen extends StatefulWidget {
  @override
  _SupportersscreenState createState() => _SupportersscreenState();
}

class _SupportersscreenState extends State<Supportersscreen> {
  TextEditingController searchController = TextEditingController();
  var currencyFormat = new NumberFormat.currency(locale: "en_US", symbol: "NGN ");

  @override
  void initState() {
    super.initState();
    Provider.of<DashBoardProvider>(context, listen: false).creatorSupporters(
        Provider.of<DashBoardProvider>(context, listen: false).creator!.username!
    );
  }

  Widget searchField(){
    return SizedBox(
      width: double.infinity,
      height: 50,
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
        onChanged: (value){
          if(value.isNotEmpty){
            if(value.length > 3){
             // Provider.of<DashBoardProvider>(context, listen: false).searchGoals(
             //     value,
             //     Provider.of<DashBoardProvider>(context, listen: false).creator.username!
             // );
            }


          }

          if(value.isEmpty){
           // Provider.of<DashBoardProvider>(context, listen: false).creatorGoals(
           //     Provider.of<DashBoardProvider>(context, listen: false).creator.username!
           // );
          }
        },

      ),
    );
  }

  Widget _btnRowWidget(){
    return Column(
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
              Provider.of<DashBoardProvider>(context, listen: false).exportSupporters(
                  Provider.of<DashBoardProvider>(context, listen: false).creator!.username!
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                )
            ),
            child: Text("Export Supporters", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
          ),
        ),
      ],
    );
  }

  Widget _supporterContainer(Supporter sup){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("${sup.name}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ref: ${sup.ref}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
                  Text("Goal Ref: ${sup.goalRef}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
                ],
              ),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Support Date: ${Jiffy(sup.createdAt).format("dd-MM-yyyy")}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Amount.: ${currencyFormat.format(sup.amount)}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),

            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Creator: ${sup.creator!.username}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Karfas: ${sup.quantity}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        //elevation: MaterialStateProperty.all(goal.active! ? 5 : 0),
                        backgroundColor: MaterialStateProperty.all(Color(0xff7cb32f))
                    ),
                    onPressed: (){
                      Get.to(() => SupporterSendMsgScreen(supporter: sup));
                    },
                    child: Text("Send Message", style: TextStyle(color: Colors.white ),),
                  ),
                  InkWell(
                    onTap: (){
                      var dProvider = Provider.of<DashBoardProvider>(context, listen: false);
                      String noteShare = sup.supports![0].note != null && sup.supports![0].note!.isNotEmpty
                          ? "${sup.name} also left this note after supporting: ${sup.supports![0].note }"
                          : "";

                      String shareText = "${sup.name} supported ${dProvider.creator!.username} with ${sup.quantity} karfas. \n" +
                          noteShare + " .You too can support ${dProvider.creator!.username} using this link https://dakwo.com/${dProvider.creator!.username} \n #dakowa #${dProvider.creator!.username}";

                      Share.share(shareText);

                    },
                    child: Icon(Icons.share, size: 16, color: mainColor,),
                  )
                ],
              ),
            )


          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Color(0xfff9f9f9),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: _btnRowWidget(),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: Provider.of<DashBoardProvider>(context, listen: true).supporters.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i){
                  Supporter gl = Provider.of<DashBoardProvider>(context, listen: true).supporters[i];
                  return _supporterContainer(gl);
                }
            ),
          )
        ],
      ),
    );
  }
}
