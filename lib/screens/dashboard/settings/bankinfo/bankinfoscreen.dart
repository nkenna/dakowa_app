import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/screens/dashboard/settings/bankinfo/addbankinfoscreen.dart';
import 'package:dakowa_app/screens/dashboard/settings/bankinfo/editbankinfoscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BankInfoScreen extends StatefulWidget {
  @override
  _BankInfoScreenState createState() => _BankInfoScreenState();
}

class _BankInfoScreenState extends State<BankInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var aProvider = Provider.of<DashBoardProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      height: double.infinity,
      //color: Colors.brown,
      child: aProvider.creator!.bankinfo == null
          ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("You are yet to add any bank payment info", style: TextStyle(fontFamily: 'KiwiMedium', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),),
            SizedBox(height: 10,),
            Text("We need this information to process your support payout", style: TextStyle(fontFamily: 'KiwiRegular', fontWeight: FontWeight.normal, color: Colors.black45, fontSize: 13),),

            SizedBox(height: 20,),

            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Get.to(() => AddBankInfoScreen());
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
                child: Text("Add Bank Info", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
              ),
            ),

          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            ListTile(
              title: Text("Bank Name: "),
              subtitle: Text("${aProvider.creator!.bankinfo!.bankName}"),
            ),

            ListTile(
              title: Text("Account Number: "),
              subtitle: Text("${aProvider.creator!.bankinfo!.accountNumber}"),
            ),

            ListTile(
              title: Text("Account Name: "),
              subtitle: Text("${aProvider.creator!.bankinfo!.accountName}"),
            ),

            ListTile(
              title: Text("Account Name: "),
              subtitle: Text("${aProvider.creator!.bankinfo!.bankCode}"),
            ),

            SizedBox(height: 20,),

            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Get.to(() => EditBankInfoScreen());
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2ad3e0)),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
                child: Text("Edit Bank Info", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w900),),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
