import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('JSON Parse'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {
              final index = position~/2;

              if (position.isOdd) return new Divider();
              return new ListTile(
                onTap: (){_showOnTapMessage(context, _data[index]['userId'], _data[index]['id'], _data[index]['body']);},
                leading: new CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: new Text("${_data[index]['userId']}"),
                ),
                title: new Text(
                  "${_data[index]['title']}",
                  style: new TextStyle(fontSize: 15.0),
                ),
                subtitle: new Text(
                  "${_data[index]['body']}",
                  style: new TextStyle(fontSize: 12.0),
                ),
              );
            }),
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context,int usrId, int pstId, String message){
  var alert = new AlertDialog(
    title: new Text("User ID: $usrId Post ID: $pstId"),
    content: new Text("$message"),
    actions: <Widget>[
      new FlatButton(onPressed: (){Navigator.pop(context);}, child: new Text("Ok"))
    ],
  );
  showDialog(context: context, child: alert, barrierDismissible: false);
}

Future<List> getJson() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}
