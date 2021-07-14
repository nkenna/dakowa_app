import 'package:dakowa_app/models/support.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class SupportsScreen extends StatefulWidget {
  @override
  _SupportsScreenState createState() => _SupportsScreenState();
}

class _SupportsScreenState extends State<SupportsScreen> {

  TextEditingController searchController = TextEditingController();
  var currencyFormat = new NumberFormat.currency(locale: "en_US", symbol: "NGN ");

  @override
  void initState() {
    super.initState();
    Provider.of<DashBoardProvider>(context, listen: false).creatorSupports(
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
            child: Text("Export Supports", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
          ),
        ),
      ],
    );
  }

  Widget _supportContainer(Support sup){
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
                  Text("Date: ${Jiffy(sup.createdAt).format("dd-MM-yyyy")}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
                  Text("Type: ${sup.supportType}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
                ],
              ),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Final. Amt.: ${currencyFormat.format(sup.finalAmount)}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
                  Text("Comm.: ${currencyFormat.format(sup.charges)}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
                ],
              ),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Amount: ${currencyFormat.format(sup.amount)}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Ref: ${sup.ref}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            Divider(height: 3, thickness: 3, color: mainColor, indent: 1, endIndent: 1,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Payment Ref: ${sup.paymentRef}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),
            ),
            //Text("Supporter: ${sup.paymentRef}", maxLines: 1, style: TextStyle(color: mainColor, fontFamily: 'KiwiMedium', fontSize: 12),),



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
                itemCount: Provider.of<DashBoardProvider>(context, listen: true).supports.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i){
                  Support gl = Provider.of<DashBoardProvider>(context, listen: true).supports[i];
                  return _supportContainer(gl);
                }
            ),
          )
        ],
      ),
    );
  }
}
