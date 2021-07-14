import 'package:dakowa_app/providers/searchprovider.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchFeild extends StatefulWidget {
  TextEditingController? searchController;

  SearchFeild({this.searchController});

  @override
  _SearchFeildState createState() => _SearchFeildState();
}

class _SearchFeildState extends State<SearchFeild> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)!.insert(_overlayEntry!);
      }else{
        _overlayEntry!.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    List<String> searchResults = [];
    Provider.of<SearchProvider>(context, listen: false).retrieveSearches().then((values) {
      print("SESRCHHHHH8888H");
      print(values);
      searchResults.addAll(values!);
    });

    print(searchResults);

    return OverlayEntry(
        builder: (context) =>
            Positioned(
              //left: 0,
              //right: 0,
              top: offset.dy + size.height + 7.0,
              width: Get.width,
              child: Material(
                elevation: 4.0,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: List.generate(searchResults.length, (index) =>
                  ListTile(
                    onTap: (){
                      widget.searchController!.text = searchResults[index];
                      _overlayEntry!.remove();
                      setState(() {});
                    },
                  leading: Icon(Icons.search_rounded, color: mainColor,),
                      title: Text("${searchResults[index]}", style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular'),),
                      trailing: Icon(Icons.arrow_forward_rounded, color: mainColor,),
                    ),
                  )
                ),
              ),
            )
    );
  }

  Widget searchField(){
    return Expanded(
      child: TextField(
        focusNode: _focusNode,
        controller: widget.searchController,
        style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular'),
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
            hintStyle: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'KiwiRegular')
        ),
        onChanged: (query) async{
          print(query);
           if(query.isNotEmpty && query.length > 3){
             Provider.of<SearchProvider>(context, listen: false).setFutureSearch(
                 Provider.of<SearchProvider>(context, listen: false).search(query)
             );

            return;
          }

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return searchField();
  }
}
