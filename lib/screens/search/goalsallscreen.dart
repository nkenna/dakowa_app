import 'package:dakowa_app/models/goal.dart';
import 'package:dakowa_app/providers/searchprovider.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GoalsAllScreen extends StatefulWidget {
  @override
  _GoalsAllScreenState createState() => _GoalsAllScreenState();
}

class _GoalsAllScreenState extends State<GoalsAllScreen> {
  var currencyFormat = new NumberFormat.currency(locale: "en_US", symbol: "NGN ");

  Widget alteContainer({String? text}){
    return Container(
      width: double.infinity,
      height: double.infinity,
     // color: Colors.redAccent,
      child: Center(
        child: Text(text!),
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : print( 'Could not launch $url');

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
              return alteContainer(text: "No Goal found.....");
            }
            else if(snapshot.connectionState == ConnectionState.done){
              return snapshot.hasData == true && snapshot.data!.length == 0 ?
              alteContainer(text: "No Goal found.....")
              : ListView.builder(
                  itemCount: snapshot.data!['goals'].length,
                  itemBuilder: (context, int i){
                    Goal goal = snapshot.data!['goals'][i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                        onTap: (){
                          _launchURL("https://dakowa.com/goal/${goal.creator!.username}/${goal.ref}");
                        },
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
                                Text("${goal.title}", style: TextStyle(color: Colors.white),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("From: ${Jiffy(goal.startDate).yMd}", style: TextStyle(color: Colors.white, fontSize: 12),),
                                    Text("To: ${Jiffy(goal.endDate).yMd}", style: TextStyle(color: Colors.white, fontSize: 12),),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("M. Amt: ${currencyFormat.format(goal.maxAmount)}", style: TextStyle(color: Colors.white, fontSize: 12),),
                                    Text("Amt: ${currencyFormat.format(goal.amountGotten)}", style: TextStyle(color: Colors.white, fontSize: 12),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
            else{
              return alteContainer(text: "No Goal found.....");
            }
          },
        )
    );
  }
}
