
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lesson.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String courseName;
  int courseCredit = 1;
  double lessonLetterValue = 4;
  List<lesson> allLesson;
  double _average = 0;
  static int count = 0;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allLesson = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait)
            return body();
          else
            return _bodyLandscape();
        },
      ),
    );
  }

  body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Static formları tutan container
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //color: Colors.pink.shade100,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      hintText: "Ders Adını Giriniz",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                      labelStyle: TextStyle(fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.length > 0) {
                        return null;
                      } else
                        return "Ders adı boş olamaz";
                    },
                    onSaved: (String kaydedilecekDeger) {
                      courseName = kaydedilecekDeger;
                      setState(() {
                        allLesson.add(lesson(courseName, lessonLetterValue, courseCredit,
                            rastgeleRenkOlustur()));
                        _average = 0;
                        _ortalamayiHesapla();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: _dersKrediItems(),
                            value: courseCredit,
                            onChanged: (secilenKredi) {
                              setState(() {
                                courseCredit = secilenKredi;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: _dersHarfDegerleriItems(),
                            value: lessonLetterValue,
                            onChanged: (secilenHarf) {
                              setState(() {
                                lessonLetterValue = secilenHarf;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              border: BorderDirectional(
                top: BorderSide(color: Colors.blue, width: 2),
                bottom: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: allLesson.length == 0
                            ? " Lütfen ders ekleyin "
                            : "Ortalama : ",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: allLesson.length == 0
                          ? ""
                          : "${_average.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //dinamik liste tutan container
          Expanded(
            child: Container(
              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: allLesson.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyLandscape() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  //color: Colors.pink.shade100,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Ders Adı",
                            hintText: "Ders Adını Giriniz",
                            hintStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                            labelStyle: TextStyle(fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.purple, width: 2),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.purple, width: 2),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide:
                              BorderSide(color: Colors.blue, width: 2),
                            ),
                          ),
                          validator: (girilenDeger) {
                            if (girilenDeger.length > 0) {
                              return null;
                            } else
                              return "Ders adı boş olamaz";
                          },
                          onSaved: (String kaydedilecekDeger) {
                            courseName = kaydedilecekDeger;
                            setState(() {
                              allLesson.add(lesson(courseName, lessonLetterValue,
                                  courseCredit, rastgeleRenkOlustur()));
                              _average = 0;
                              _ortalamayiHesapla();
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 4),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 2),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  items: _dersKrediItems(),
                                  value: courseCredit,
                                  onChanged: (secilenKredi) {
                                    setState(() {
                                      courseCredit = secilenKredi;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 4),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 2),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<double>(
                                  items: _dersHarfDegerleriItems(),
                                  value: lessonLetterValue,
                                  onChanged: (secilenHarf) {
                                    setState(() {
                                      lessonLetterValue = secilenHarf;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      border: BorderDirectional(
                        top: BorderSide(color: Colors.blue, width: 2),
                        bottom: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: allLesson.length == 0
                                    ? " Lütfen ders ekleyin "
                                    : "Ortalama : ",
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: allLesson.length == 0
                                  ? ""
                                  : "${_average.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: _listeElemanlariniOlustur,
                  itemCount: allLesson.length,
                ),
              ),
              flex: 1),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> _dersKrediItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i <= 10; i++) {
      //var kredi = DropdownMenuItem<int>(value: i,child: Text("$i Kredi"),);
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text(
          "$i Kredi",
          style: TextStyle(fontSize: 20),
        ),
      ));
    }

    return krediler;
  }

  List<DropdownMenuItem<double>> _dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(
      child: Text(
        " AA ",
        style: TextStyle(fontSize: 20),
      ),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BA ",
        style: TextStyle(fontSize: 20),
      ),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BB ",
        style: TextStyle(fontSize: 20),
      ),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CB ",
        style: TextStyle(fontSize: 20),
      ),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CC ",
        style: TextStyle(fontSize: 20),
      ),
      value: 2,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DC ",
        style: TextStyle(fontSize: 20),
      ),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DD ",
        style: TextStyle(fontSize: 20),
      ),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " FD ",
        style: TextStyle(fontSize: 20),
      ),
      value: 0.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " FF",
        style: TextStyle(fontSize: 20),
      ),
      value: 0,
    ));
    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    count++;

    return Dismissible(
      key: Key(count.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          allLesson.removeAt(index);
          _ortalamayiHesapla();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: allLesson[index].color, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(4),
        child: ListTile(
          leading: Icon(
            Icons.book,
            size: 36,
            color: allLesson[index].color,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_left,
            color: allLesson[index].color,
          ),
          title: Text(allLesson[index].title),
          subtitle: Text(allLesson[index].credit.toString() +
              " Kredi Ders Not Değeri" +
              allLesson[index].letter.toString()),
        ),
      ),
    );
  }

  void _ortalamayiHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var oankiDers in allLesson) {
      var kredi = oankiDers.credit;
      var harfDegeri = oankiDers.letter;
      toplamNot += (harfDegeri * kredi);
      toplamKredi += kredi;
    }
    _average = toplamNot / toplamKredi;
  }

  Color rastgeleRenkOlustur() {
    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}

