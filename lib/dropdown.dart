
import 'package:flutter/material.dart';

typedef StringCallback = void Function(String seleectedValue);

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({
    this.locationsList,
    this.requiredDrop,
    this.onChanged,
    this.stringCallback,
    Key? key,
  }) : super(key: key);

  final List<String>? locationsList;
  final bool? requiredDrop;
  final StringCallback? stringCallback;
  final Function? onChanged;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.locationsList![0];
  }


  @override
  Widget build(BuildContext context) {
    var safeHeight = MediaQuery.of(context).size.height;
    var safeWidth = MediaQuery.of(context).size.width;

    return Container(
      padding:  EdgeInsets.all(5),
      margin: const EdgeInsets.all(3.0),
      width: safeWidth / 2,
      height: 30,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: Colors.black,
          )),
      child: Center(
        child: DropdownButton<String>(

          value: dropdownValue,
          // icon: const Icon(
          //   Icons.arrow_downward,
          //   color: Colors.black,
          // ),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
          ),

          onChanged: (String? newValue) {
            setState((){
              dropdownValue = newValue!;
              widget.stringCallback!(dropdownValue);

              // print(dropdownValue);
            });
          },
          items: widget.locationsList!
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: widget.requiredDrop! ? Text("$value", textAlign: TextAlign.center,) : Text(value),
            );
          }).toList(),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
