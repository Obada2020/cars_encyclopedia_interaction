import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cars_encyclopedia_interaction/Extension_Widget/addPostFromCallback.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data.dart';
import 'model.dart';

class DetailsPage extends StatefulWidget {
  final EncyclopediaCar car;
  final int index;
  const DetailsPage({Key? key, required this.car, required this.index})
      : super(key: key);

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        isExpanded = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          setState(() {
            isExpanded = false;
          });
          ThemeSwitcher.of(context).changeTheme(
              theme: ThemeData(
            primaryColor: Colors.black,
            brightness: Brightness.dark,
          ));
          Future.delayed(const Duration(milliseconds: 800), () {
            Navigator.pop(context);
          });
          return Future.value(false);
        },
        child: ThemeProvider(
          duration: const Duration(milliseconds: 1200),
          initTheme: ThemeData(
            primaryColor: Colors.black,
            primaryColorLight: Colors.white,
            brightness: Brightness.dark,
            textTheme: GoogleFonts.abrilFatfaceTextTheme(),
          ),
          builder: (x, y) => ThemeSwitchingArea(
            child: AnimatedContainer(
              // curve: Curves.easeInOutBack,
              duration: const Duration(milliseconds: 1200),
              padding: EdgeInsets.only(top: isExpanded ? 40 : 0),
              // transform: Matrix4.translationValues(
              //   0,
              //   isExpanded ? 40 : 0,
              //   0,
              // ),
              decoration: BoxDecoration(
                color: y.primaryColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        valuesDataColors[widget.index].dates.split('-')[0],
                        style: const TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text('-', style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      Text(
                        valuesDataColors[widget.index].dates.split('-')[1],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 0.5
                            ..color = Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    // padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          curve: Curves.easeInOutBack,
                          right: isExpanded ? -200 : 20,
                          left: isExpanded ? 80 : 20,
                          duration: const Duration(milliseconds: 1200),
                          child: Image.asset(
                            valuesDataColors[widget.index].image,
                            width: isExpanded ? 500 : 350,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [1, 2, 3, 4]
                          .map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(e.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [1]
                          .map(
                            (e) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.circle,
                                color: Colors.white,
                                size: 8,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Image.asset(
                        valuesDataColors[widget.index].logo,
                        width: 30,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        valuesDataColors[widget.index].name,
                        style: GoogleFonts.abrilFatface(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: y.primaryColorDark,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey[100],
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Production'),
                            const SizedBox(height: 10),
                            Text(
                              valuesDataColors[widget.index].production,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(width: 60),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Class'),
                            const SizedBox(height: 10),
                            Text(
                              valuesDataColors[widget.index].classs,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ThemeSwitcher(
                    clipper: const ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return Container(
                        color: Colors.transparent,
                        width: 25,
                        height: 25,
                      ).addPostFrameCallback(
                        () {
                          if (context.mounted) {
                            if (!isExpanded) {
                              Future.delayed(const Duration(milliseconds: 2000),
                                  () {
                                ThemeSwitcher.of(context).changeTheme(
                                  theme: y.brightness == Brightness.dark
                                      ? ThemeData(
                                          primaryColor: Colors.white,
                                          brightness: Brightness.light,
                                        )
                                      : ThemeData(
                                          primaryColor: Colors.black,
                                          brightness: Brightness.dark,
                                        ),
                                  // theme: ThemeData(
                                  //   primaryColor: Colors.white,
                                  //   brightness: Brightness.light,
                                  //   primaryColorLight: Colors.black,
                                  // ),
                                );
                              });
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
