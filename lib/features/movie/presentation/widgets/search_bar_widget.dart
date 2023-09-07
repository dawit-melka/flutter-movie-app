import 'package:flutter/material.dart';
import 'package:mobile/core/color/colors.dart';


class SearchBarWidget extends StatefulWidget {
  final Function searchByName;
  const SearchBarWidget({super.key, required this.searchByName});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 65,
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            border: Border.all(color: tilesColor),
            color: tilesColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onEditingComplete: (){
                widget.searchByName(queryController.text);
              },
              controller: queryController,
              decoration: InputDecoration(
                hintText: 'Looking for shows',
                hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            widget.searchByName(queryController.text);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Icon(
            Icons.search, // Clear icon
            color: Color.fromRGBO(211, 232, 255, 1),
            size: 40,
          ),
        ),
      ],
    );
  }
}
