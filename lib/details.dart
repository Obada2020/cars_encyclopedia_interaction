import 'dart:developer';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animate_divider.dart';
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
  final mybuttonkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 800), () async {
        setState(() {
          isExpanded = true;
        });
        // return;
        await Future.delayed(const Duration(milliseconds: 400), () {});
        RenderBox renderbox =
            mybuttonkey.currentContext!.findRenderObject() as RenderBox;
        Offset position = renderbox.localToGlobal(Offset.zero);
        final x = position.dx;
        final y = position.dy;
        log(x.toString());
        log(y.toString());
        GestureBinding.instance.handlePointerEvent(
            PointerDownEvent(position: Offset(x, y))); //trigger button up,
        await Future.delayed(const Duration(milliseconds: 500));
        GestureBinding.instance
            .handlePointerEvent(PointerUpEvent(position: Offset(x, y)));
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
        RenderBox renderbox =
            mybuttonkey.currentContext!.findRenderObject() as RenderBox;
        Offset position = renderbox.localToGlobal(Offset.zero);
        final x = position.dx;
        final y = position.dy;
        log(x.toString());
        log(y.toString());
        GestureBinding.instance
            .handlePointerEvent(PointerDownEvent(position: Offset(x, y)));
        GestureBinding.instance
            .handlePointerEvent(PointerUpEvent(position: Offset(x, y)));
        await Future.delayed(const Duration(milliseconds: 800), () {});
        setState(() {
          isExpanded = false;
        });
        await Future.delayed(const Duration(milliseconds: 800), () {});

        return Future.value(true);
      },
      child: ThemeProvider(
        duration: const Duration(milliseconds: 1300),
        initTheme: ThemeData(
          primaryColor: Colors.black,
          primaryColorLight: Colors.white,
          brightness: Brightness.dark,
          textTheme: GoogleFonts.abrilFatfaceTextTheme().copyWith(
            titleLarge: GoogleFonts.abrilFatface(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            // titleSmall: const TextStyle(
            //   color: Colors.white,
            //   fontSize: 16,
            // ),
            // titleMedium: const TextStyle(
            //   color: Colors.white,
            //   fontSize: 18,
            // ),
          ),
        ),
        builder: (x, y) => ThemeSwitchingArea(
          child: AnimatedContainer(
            // curve: Curves.easeInOutBack,
            duration: const Duration(milliseconds: 1200),
            padding: EdgeInsets.only(top: isExpanded ? 40 : 0),
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
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 500),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    secondChild: const SizedBox.shrink(),
                    firstChild: IconButton(
                      onPressed: () async {
                        RenderBox renderbox = mybuttonkey.currentContext!
                            .findRenderObject() as RenderBox;
                        Offset position = renderbox.localToGlobal(Offset.zero);
                        final x = position.dx;
                        final y = position.dy;
                        log(x.toString());
                        log(y.toString());
                        GestureBinding.instance.handlePointerEvent(
                            PointerDownEvent(position: Offset(x, y)));
                        GestureBinding.instance.handlePointerEvent(
                            PointerUpEvent(position: Offset(x, y)));
                        await Future.delayed(
                            const Duration(milliseconds: 1000), () {});
                        setState(() {
                          isExpanded = false;
                        });
                        await Future.delayed(
                            const Duration(milliseconds: 800), () {});
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.navigate_before,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 30),
                    Text(
                      valuesDataColors[widget.index].dates.split('-')[0],
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: y.textTheme.titleLarge!.color!,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text('-',
                        style: TextStyle(
                          color: y.textTheme.titleLarge!.color!,
                        )),
                    const SizedBox(width: 10),
                    Text(
                      valuesDataColors[widget.index].dates.split('-')[1],
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: y.textTheme.titleLarge!.color!,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 0.5
                          ..color = y.textTheme.titleLarge!.color!,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      style: y.textTheme.titleLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: AnimatedDivider(
                    colors: [
                      y.textTheme.titleLarge!.color!,
                      y.textTheme.titleLarge!.color!
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Production', style: y.textTheme.titleSmall),
                          const SizedBox(height: 10),
                          Text(valuesDataColors[widget.index].production,
                              style: y.textTheme.titleMedium),
                        ],
                      ),
                      const SizedBox(width: 60),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Class', style: y.textTheme.titleSmall),
                          const SizedBox(height: 10),
                          Text(valuesDataColors[widget.index].classs,
                              style: y.textTheme.titleMedium),
                        ],
                      ),
                    ]
                        .animate(
                          delay: const Duration(milliseconds: 800),
                          interval: const Duration(milliseconds: 200),
                        )
                        .slideY(
                          duration: const Duration(milliseconds: 200),
                          // delay: const Duration(milliseconds: 400),
                          begin: 1,
                        )
                        .fade(),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description', style: y.textTheme.titleSmall),
                        const SizedBox(height: 10),
                        Text(valuesDataColors[widget.index].description,
                            style: y.textTheme.titleMedium),
                      ],
                    ),
                  ),
                )
                    .animate(
                      delay: const Duration(milliseconds: 800),
                    )
                    .slideY(
                      duration: const Duration(milliseconds: 200),
                      // delay: const Duration(milliseconds: 400),
                      begin: 1,
                    )
                    .fade(),
                const SizedBox(
                  height: 100,
                ),
                ThemeSwitcher(
                  clipper: const ThemeSwitcherCircleClipper(),
                  builder: (context) {
                    return IconButton(
                      key: mybuttonkey,
                      color: Colors.transparent,
                      icon: const SizedBox(
                        width: 20,
                      ),
                      onPressed: () {
                        log('message');
                        // if (!isExpanded) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: y.brightness == Brightness.dark
                                ? ThemeData(
                                    primaryColor: Colors.white,
                                    brightness: Brightness.light,
                                    textTheme:
                                        GoogleFonts.abrilFatfaceTextTheme(
                                            Theme.of(context)
                                                .textTheme
                                                .copyWith(
                                                  titleLarge: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )).copyWith(
                                      titleSmall: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      titleMedium: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : ThemeData(
                                    primaryColor: Colors.black,
                                    brightness: Brightness.dark,
                                    textTheme:
                                        GoogleFonts.abrilFatfaceTextTheme(
                                      Theme.of(context).textTheme.copyWith(
                                            titleLarge: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                    ),
                                  ),
                            isReversed:
                                y.brightness != Brightness.dark ? true : false,
                          );
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
