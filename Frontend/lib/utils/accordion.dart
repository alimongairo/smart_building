import 'dart:convert';

import 'package:flutter/material.dart';

String testBuildingData = '{"building": {"Floor#1": "Room#101", "Floor#2": "Room#201"}}';

Map<String, dynamic> getInfoFromMap(String data) {
  Map<String, dynamic> infoB = jsonDecode(data);
  String tmp = jsonEncode(infoB['building']);
  Map<String, dynamic> infoF = jsonDecode(tmp);
  return infoF;
}

String getDataKey(Map map){
  String result = '';
  for (var key in map.keys) {
    result = key;
  }
  return result;
}

List getDataKeys(Map map){
  List result = [];
  for (var key in map.keys) {
    result.add(key);
  }
  return result;
}

List getDataValues(Map map){
  List result = [];
  for (var key in map.values) {
    result.add(key);
  }
  return result;
}


class AccordionList extends StatefulWidget {
  const AccordionList({Key? key}) : super(key: key);

  @override
  State<AccordionList> createState() => _AccordionListState();
}

class _AccordionListState extends State<AccordionList> {
  final bool _customTileExpanded = false;

  Map<String, dynamic> data = getInfoFromMap(testBuildingData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        for (var i in getDataKeys(data))
          ExpansionTile(
              title: Text(i),
              controlAffinity: ListTileControlAffinity.leading,
              leading: Icon(
                _customTileExpanded
                    ? Icons.arrow_drop_down_circle
                    : Icons.arrow_drop_down,),
              children:[
                ListTile(title: Text(data[i]))
              ]
          ),
      ],
    );
  }
}
