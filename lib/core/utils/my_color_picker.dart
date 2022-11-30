import 'package:flutter/material.dart';

class MyColorpicker extends StatefulWidget {
  const MyColorpicker({Key? key}) : super(key: key);

  @override
  MyColorpickerState createState() => MyColorpickerState();
}

class MyColorpickerState extends State<MyColorpicker> {
  static var colorvalue = Colors.white;
  static List<dynamic> colorlist = [];

  static Future<Color> colorChooseSingle(context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: const Center(
                child: Text(
              "Choose Color",
              style: TextStyle(fontWeight: FontWeight.w800),
            )),
            content: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.blue
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.blue,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.blue;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.green
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.green,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.green;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.red
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.red,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.red;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.yellow
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.yellow,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.yellow;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.purple
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.purple,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.purple;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.pink
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.pink,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.pink;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.brown
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.brown,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.brown;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.grey
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.grey,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.grey;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.cyan
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.cyan,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.cyan;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.deepOrange
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.deepOrange,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.deepOrange;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.indigo
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.indigo,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.indigo;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.lightBlue
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.lightBlue,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.lightBlue;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.lime,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.lime
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.lime,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.lime;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.greenAccent
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.greenAccent,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.greenAccent;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.tealAccent,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.tealAccent
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.tealAccent,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.tealAccent;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.pinkAccent
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.pinkAccent,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.pinkAccent;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.white
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.white,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.white;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorvalue == Colors.black
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.black,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              colorvalue = Colors.black;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pop(context);
                    // dialog();
                    // setState((){});
                  },
                  child: const Text("OK"))
            ],
          );
        });
    return colorvalue;
  }

  static Future<dynamic> colorChooseMultiple(context) async {
    colorlist.clear();

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: Colors.white.withOpacity(0.9),
            title: const Center(
                child: Text(
              "Choose Colors",
              style: TextStyle(fontWeight: FontWeight.w800),
            )),
            content: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any((element) => element == Colors.blue)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.blue,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            int cnt = 0;
                            for (int i = 0; i < colorlist.length; i++) {
                              if (colorlist[i] == Colors.blue) {
                                cnt++;
                              }
                            }
                            // print(cnt);
                            if (cnt == 0) {
                              colorlist.add(Colors.blue);
                            } else {
                              colorlist.remove(Colors.blue);
                            }

                            setState(() {});
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist
                                      .any((element) => element == Colors.green)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.green,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            int cnt = 0;
                            for (int i = 0; i < colorlist.length; i++) {
                              if (colorlist[i] == Colors.green) {
                                cnt++;
                              }
                            }
                            // print(cnt);
                            if (cnt == 0) {
                              colorlist.add(Colors.green);
                            } else {
                              colorlist.remove(Colors.green);
                            }
                            setState(() {});
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any((element) => element == Colors.red)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.red,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            int cnt = 0;
                            for (int i = 0; i < colorlist.length; i++) {
                              if (colorlist[i] == Colors.red) {
                                cnt++;
                              }
                            }
                            // print(cnt);
                            if (cnt == 0) {
                              colorlist.add(Colors.red);
                            } else {
                              colorlist.remove(Colors.red);
                            }
                            setState(() {});
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any(
                                      (element) => element == Colors.yellow)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.yellow,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.yellow) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.yellow);
                              } else {
                                colorlist.remove(Colors.yellow);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any(
                                      (element) => element == Colors.purple)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.purple,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.purple) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.purple);
                              } else {
                                colorlist.remove(Colors.purple);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any((element) => element == Colors.pink)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.pink,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.pink) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.pink);
                              } else {
                                colorlist.remove(Colors.pink);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist
                                      .any((element) => element == Colors.brown)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.brown,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.brown) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.brown);
                              } else {
                                colorlist.remove(Colors.brown);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any((element) => element == Colors.grey)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.grey,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.grey) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.grey);
                              } else {
                                colorlist.remove(Colors.grey);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any((element) => element == Colors.cyan)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.cyan,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.cyan) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.cyan);
                              } else {
                                colorlist.remove(Colors.cyan);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any(
                                      (element) => element == Colors.deepOrange)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.deepOrange,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.deepOrange) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.deepOrange);
                              } else {
                                colorlist.remove(Colors.deepOrange);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any(
                                      (element) => element == Colors.indigo)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.indigo,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.indigo) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.indigo);
                              } else {
                                colorlist.remove(Colors.indigo);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any(
                                      (element) => element == Colors.lightBlue)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.lightBlue,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.lightBlue) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.lightBlue);
                              } else {
                                colorlist.remove(Colors.lightBlue);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.lime,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any((element) => element == Colors.lime)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.lime,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.lime) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.lime);
                              } else {
                                colorlist.remove(Colors.lime);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any((element) =>
                                      element == Colors.greenAccent)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.greenAccent,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.greenAccent) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.greenAccent);
                              } else {
                                colorlist.remove(Colors.greenAccent);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.tealAccent,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any(
                                      (element) => element == Colors.tealAccent)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.tealAccent,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.tealAccent) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.tealAccent);
                              } else {
                                colorlist.remove(Colors.tealAccent);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist.any(
                                      (element) => element == Colors.pinkAccent)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.pinkAccent,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.pinkAccent) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.pinkAccent);
                              } else {
                                colorlist.remove(Colors.pinkAccent);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist
                                      .any((element) => element == Colors.white)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.white,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.white) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.white);
                              } else {
                                colorlist.remove(Colors.white);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              colorlist
                                      .any((element) => element == Colors.black)
                                  ? const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.black,
                                        // backgroundImage: Icon(Icons.check),
                                      ),
                                    )
                                  : Container()
                            ],
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            setState(() {
                              int cnt = 0;
                              for (int i = 0; i < colorlist.length; i++) {
                                if (colorlist[i] == Colors.black) {
                                  cnt++;
                                }
                              }
                              if (cnt == 0) {
                                colorlist.add(Colors.black);
                              } else {
                                colorlist.remove(Colors.black);
                              }
                            });
                            // print(colorlist);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // setState((){});
                  },
                  child: const Text("OK"))
            ],
          );
        });
    return colorlist;
  }

  @override
  void initState() {
    // colorChooseSingle(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
