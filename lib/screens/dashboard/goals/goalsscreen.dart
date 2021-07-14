import 'package:dakowa_app/models/goal.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  TextEditingController searchController = TextEditingController();
  var currencyFormat = new NumberFormat.currency(locale: "en_US", symbol: "NGN ");

  @override
  void initState() {
    super.initState();
    Provider.of<DashBoardProvider>(context, listen: false).creatorGoals(
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
              Provider.of<DashBoardProvider>(context, listen: false).searchGoals(
                  value,
                  Provider.of<DashBoardProvider>(context, listen: false).creator!.username!
              );
            }


          }

          if(value.isEmpty){
            Provider.of<DashBoardProvider>(context, listen: false).creatorGoals(
                Provider.of<DashBoardProvider>(context, listen: false).creator!.username!
            );
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
             // showDialog(
             //     context: context,
             //     builder: (BuildContext context){
             //       return CreateGoalModal();
             //     }
             // );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                )
            ),
            child: Text("Create a Goal", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
          ),
        ),
      ],
    );
  }

  Widget _goalContainer(Goal goal){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("${goal.title}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Start Date: ${Jiffy(goal.startDate).format("dd/MM/yy")}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
                  Text("Start Date: ${Jiffy(goal.endDate).format("dd/MM/yy")}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
                ],
              ),
            ),
            Divider(height: 3, thickness: 3, color: goal.active! ? mainColor : Colors.red, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Max. Amt.: ${currencyFormat.format(goal.maxAmount)}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            Divider(height: 3, thickness: 3, color: goal.active! ? mainColor : Colors.red, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Amt. Gotten: ${currencyFormat.format(goal.amountGotten)} (${(goal.amountGotten!*100)/goal.maxAmount!}%)", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Creator: ${goal.creator!.username}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Supporters: ${goal.supporters!.length}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(goal.active! ? 5 : 0),
                        backgroundColor: MaterialStateProperty.all(goal.active! ? Colors.white : Colors.red)
                    ),
                    onPressed: goal.active! ? (){
                      var dProvider = Provider.of<DashBoardProvider>(context, listen: false);
                      bool status = goal.active! ? false : true;
                      dProvider.activateDeactivateGoal(dProvider.creator!.username!, goal.ref!, status);
                    } : null,
                    child: Text("${goal.active! ? "Deactivate" : "Activate"}", style: TextStyle(color: goal.active! ? Colors.green : Colors.white, fontSize: 12, fontFamily: 'KiwiRegular' ),),
                  ),
                  InkWell(
                    onTap: (){
                      var dProvider = Provider.of<DashBoardProvider>(context, listen: false);
                      Share.share("https://dakowa.com/${dProvider.creator != null ? dProvider.creator!.username : ""}/${goal.ref}");

                    },
                    child: Icon(Icons.copy, size: 16, color: mainColor,),
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
                itemCount: Provider.of<DashBoardProvider>(context, listen: true).goals.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i){
                  Goal gl = Provider.of<DashBoardProvider>(context, listen: true).goals[i];
                  return _goalContainer(gl);
                }
            ),
          )
        ],
      ),
    );
  }
}
