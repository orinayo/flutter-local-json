import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Person> data;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Load JSON App"),
        ),
        body: new Container(
          child: new Center(
              child: new FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString("load_json/person.json"),
                  builder: (context, snapshot) {
                    final personsList = jsonDecode(snapshot.data.toString());
                    return new ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return new Card(
                            child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Text("Name: " + personsList[index]["name"]),
                            new Text("age: " + personsList[index]["age"]),
                            new Text("height: " + personsList[index]["height"]),
                            new Text("gender: " + personsList[index]["gender"]),
                            new Text("hair_color: " +
                                personsList[index]["hair_color"]),
                          ],
                        ));
                      },
                      itemCount: personsList == null ? 0 : personsList.length,
                    );
                  })),
        ));
  }
}

class Person {
  final String name;
  final String age;
  final String height;
  final String gender;
  final String hairColor;

  Person(this.name, this.age, this.height, this.gender, this.hairColor);

  Person.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        age = json["age"],
        height = json["height"],
        gender = json["gender"],
        hairColor = json["hair_color"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "height": height,
        "gender": gender,
        "hair_color": hairColor,
      };
}
