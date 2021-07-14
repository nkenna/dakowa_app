import 'package:dakowa_app/models/bank.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBankInfoScreen extends StatefulWidget {
  @override
  _EditBankInfoScreenState createState() => _EditBankInfoScreenState();
}

class _EditBankInfoScreenState extends State<EditBankInfoScreen> {
  Bank? _bank;
  bool _isVerified = false;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();


  Widget _accountNumberField(){
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: accountNumberController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffe9f0f4),
                contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Enter Bank Account Number",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _accountNameField(){
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: accountNameController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            readOnly: true,
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffe9f0f4),
                contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Enter Bank Account Name",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _bankNameField(){
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: bankNameController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            readOnly: true,
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffe9f0f4),
                contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintText: "Enter Bank Name",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  Widget _bankSelect(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: SizedBox(
        width: double.infinity,//ResponsiveWidget.isLargeScreen(context) ? size.width * 0.3 : size.width,
        height: 40,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffe9f0f4),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Bank>(
              hint: Text("Select Bank",
                  style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 13)
              ),
              value: _bank,
              icon: Icon(Icons.arrow_drop_down, color: mainColor,),
              elevation: 10,
              style: TextStyle(color: mainColor),
              underline: Container(
                height: 1,
                color: Colors.transparent,
              ),
              onChanged: (value){
                //Provider.of<InventoryProvider>(context, listen: false).setSelectedCategory(value!);
                setState(() {
                  _bank = value;
                });
              },
              isExpanded: true,
              items: Provider.of<DashBoardProvider>(context, listen: false).banks.map((value) {
                return DropdownMenuItem<Bank>(
                  value: value,
                  child: Text(value.name! , style: TextStyle(fontFamily: 'KiwiRegular', fontSize: 13),),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Bank Info", style: TextStyle(fontSize: 14, fontFamily: 'KiwiMedium'),),
        ),
        body: SingleChildScrollView(

          child: Column(
            children: [
              _bankSelect(context),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _accountNumberField(),
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: _accountNameField()
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: _bankNameField()
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: ElevatedButton(
                    onPressed: _isVerified
                        ?(){
                      //Navigator.of(context).pop();

                      Provider.of<DashBoardProvider>(context, listen: false).editBankInfo(
                          accountNumberController.text,
                          _bank!.code!,
                          Provider.of<DashBoardProvider>(context, listen: false).creator!.username!,
                          accountNameController.text,
                          _bank!.name!,
                          Provider.of<DashBoardProvider>(context, listen: false).creator!.bankinfo!.recipientId!
                      );
                    }
                        : () async{
                      if(_bank != null && accountNumberController.text.isNotEmpty){
                        final resp = await Provider.of<DashBoardProvider>(context, listen: false).verifyBankInfo(
                          accountNumberController.text,
                          _bank!.code!,
                        );
                        bankNameController.text = (_bank !=null ? _bank!.name : "")!;
                        accountNameController.text = (Provider.of<DashBoardProvider>(context, listen: false).bankData != null
                            ? Provider.of<DashBoardProvider>(context, listen: false).bankData!.accountName : "")!;
                        setState(() {
                          _isVerified = resp ? true : false;
                        });
                      }
                    },

                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainColor)
                    ),
                    child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'KiwiRegular'),),
                  )
              ),




            ],
          ),
        ),
      ),
    );
  }
}
