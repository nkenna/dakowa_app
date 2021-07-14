import 'package:dakowa_app/models/supporter.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SupporterSendMsgScreen extends StatefulWidget {
  final Supporter? supporter;

  const SupporterSendMsgScreen({Key? key, this.supporter}) : super(key: key);
  @override
  _SupporterSendMsgScreenState createState() => _SupporterSendMsgScreenState();
}

class _SupporterSendMsgScreenState extends State<SupporterSendMsgScreen> {
  TextEditingController msgController = TextEditingController();

  Widget _messageField(){
    return SizedBox(
        width: double.infinity,
        //height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: msgController,
            style: TextStyle(fontSize: 13, color: Colors.black),
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            maxLength: 1000,
            minLines: 5,
            maxLines: 10,

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

                hintText: "Enter Message Here",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff0053a7))
            ),
          ),
        )

    );

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: _messageField()
          ),

          ElevatedButton(
            style: ButtonStyle(
              //elevation: MaterialStateProperty.all(goal.active! ? 5 : 0),
                backgroundColor: MaterialStateProperty.all(Color(0xff7cb32f))
            ),
            onPressed: (){
              Provider.of<DashBoardProvider>(context, listen: false).sendMessage(
                  context,
                  msgController.text,
                  Provider.of<DashBoardProvider>(context, listen: false).creator!.id!,
                  widget.supporter!.id!,
                  widget.supporter!.email!);
            },
            child: Text("Send Message", style: TextStyle(color: Colors.white ),),
          ),
        ],
      ),
    );
  }
}
