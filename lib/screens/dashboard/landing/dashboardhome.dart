import 'package:clipboard/clipboard.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DashBoardHome extends StatefulWidget {
  @override
  _DashBoardHomeState createState() => _DashBoardHomeState();
}

class _DashBoardHomeState extends State<DashBoardHome> {
  var currencyFormat = new NumberFormat.currency(locale: "en_US", symbol: "NGN ");


  Widget infoDataContainer(Widget image, String title, String data){
    return Container(
      //width: Get.width,
      height: 100,
      //color: Colors.brown,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              image,
              Text(title, style: TextStyle(fontFamily: 'KiwiRegular', fontWeight: FontWeight.normal, color: Colors.black, fontSize: 12),)
            ],
          ),
          SizedBox(height: 10,),
          Text(data, style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12),)
        ],
      ),
    );
  }

  Widget infoContainer(){
    var dProvider = Provider.of<DashBoardProvider>(context, listen: true);

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("Overview", style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 14),),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                infoDataContainer(
                    Image.asset("assets/images/supporters.png", width: 20,),
                    "Supporters",
                    "${dProvider.creator != null
                        ? dProvider.creator!.supporters != null ? dProvider.creator!.supporters!.length : 0
                     : 0}"
                ),
                SizedBox(height: 10,),

                infoDataContainer(
                    Image.asset("assets/images/gold.png", width: 20,),
                    "Pocket Balance",
                    "${currencyFormat.format(
                        dProvider.creator != null && dProvider.creator!.pocket != null
                            ? dProvider.creator!.pocket!.balance
                            : 0)}"
                ),
                SizedBox(height: 10,),

                infoDataContainer(
                    Image.asset("assets/images/supports.png", width: 20,),
                    "Supports",
                    "${dProvider.supports.length}"
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget linkContainer(){
    var dProvider = Provider.of<DashBoardProvider>(context, listen: true);

    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xfff9f9f9)
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("https://explore.dakowa.com/${dProvider.creator != null ? dProvider.creator!.username : ""}",
                          style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Colors.black),),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 80,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )
                        )
                    ),
                    onPressed: (){
                      Share.share("https://dakowa.com/${dProvider.creator != null ? dProvider.creator!.username : ""}");


                    },
                    child: Text("Copy", style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular', color: Colors.white),),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget bankInfoContainer(){
    var dProvider = Provider.of<DashBoardProvider>(context, listen: true);

    return dProvider.creator == null || dProvider.creator!.bankinfo == null
        ? Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset("assets/images/gold.png", width: 50,),
            SizedBox(height: 15,),

            Text("You are yet to add any bank payment info", style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),),
            SizedBox(height: 10,),
            Text("We need this information to process your supports payout", style: TextStyle(fontFamily: 'KiwiRegular', fontWeight: FontWeight.normal, color: Colors.black45, fontSize: 12),),

            SizedBox(height: 20,),

            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
                onPressed: () => Provider.of<DashBoardProvider>(context, listen: false).setCurrentScreen(5),
                child: Text("Add bank Info", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
              ),
            ),

          ],
        ),
      ),
    )

        : Container();
  }

  Widget goalInfoContainer(){
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset("assets/images/goals_icon.png", width: 50,),
            SizedBox(height: 15,),

            Text("You don't have any active goal", style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),),
            SizedBox(height: 10,),
            Text("Creators with goals attract more supporters consistently. Add a goal and let it be a part of your journey.", style: TextStyle(fontFamily: 'KiwiRegular', fontWeight: FontWeight.normal, color: Colors.black45, fontSize: 12),),

            SizedBox(height: 20,),

            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
                onPressed: () => Provider.of<DashBoardProvider>(context, listen: false).setCurrentScreen(1),
                child: Text("Set a Goal", style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget integrateInfoContainer(){
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset("assets/images/custom_icon.png", width: 50,),
            SizedBox(height: 15,),

            Text("Create customizable buttons to embed into your website/page", style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12),),

            SizedBox(height: 20,),

            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
                onPressed: () => Provider.of<DashBoardProvider>(context, listen: false).setCurrentScreen(5),
                child: Text("Start Customization", style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
              ),
            ),

          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {



    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
        child: Scrollbar(
          child: SingleChildScrollView(

            child: Column(
              children: [
                infoContainer(),
                SizedBox(height: 30,),
                linkContainer(),
                SizedBox(height: 30,),
                bankInfoContainer(),
                SizedBox(height: 30,),
                Provider.of<DashBoardProvider>(context, listen: false).activeGoals == 0
                    ? goalInfoContainer() : Container(),
                SizedBox(height: 30,),
                integrateInfoContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
