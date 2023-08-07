import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cars_encyclopedia_interaction/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

import 'details.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _current = 0;
  var carouelController = CarouselController();
  var cardSwiperController = CardSwiperController();
  List<Widget> valuesWidget = [];
  @override
  void initState() {
    for (int i = 0; i < valuesDataColors.length; i++) {
      valuesWidget.add(
        OpenContainer(
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          closedElevation: 0,
          openColor: Colors.black,
          closedColor: Colors.black,
          clipBehavior: Clip.none,
          transitionDuration: const Duration(milliseconds: 1000),
          openBuilder: (context, _) => DetailsPage(
            car: valuesDataColors[i],
            index: i,
          ),
          closedBuilder: (context, openContainer) => Container(
            clipBehavior: Clip.none,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.black,
              boxShadow: [
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
                      valuesDataColors[i].dates.split('-')[0],
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[50],
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text('-', style: TextStyle(color: Colors.white)),
                    const SizedBox(width: 10),
                    Text(
                      valuesDataColors[i].dates.split('-')[1],
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Image.asset(
                    valuesDataColors[i].image,
                    width: 350,
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
                                style: const TextStyle(color: Colors.white)),
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
                      valuesDataColors[i].logo,
                      width: 30,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      valuesDataColors[i].name,
                      style: GoogleFonts.abrilFatface(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[100],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Plus Jakarta Sans',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Timeline', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.grey[50],
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () {},
          ),
        ),
        body: ListView(
          clipBehavior: Clip.none,
          children: [
            const SizedBox(height: 30),
            CarouselSlider.builder(
              carouselController: carouelController,
              options: CarouselOptions(
                viewportFraction: 0.38,
                aspectRatio: 2.0,
                initialPage: 0,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _current = index;
                    },
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
              itemCount: dates.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  foreground: _current != itemIndex
                      ? (Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.5
                        ..color = Colors.black)
                      : Paint(),
                  fontSize: _current == itemIndex ? 45 : 35,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: _current == itemIndex
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
                child: Text(
                  dates[itemIndex].toString(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.62,
              child: CardSwiper(
                controller: cardSwiperController,
                onSwipe: (x, y, CardSwiperDirection z) {
                  inspect(z);
                  if (z.name == 'left') {
                    carouelController.nextPage();
                  } else {
                    carouelController.previousPage();
                  }
                  return true;
                },
                allowedSwipeDirection:
                    AllowedSwipeDirection.only(left: true, right: true),
                backCardOffset: const Offset(5, -30),
                direction: CardSwiperDirection.right,
                padding: const EdgeInsets.only(left: 0, right: 0),
                scale: 0.9,
                cardsCount: valuesWidget.length,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) =>
                        InkWell(
                  onTap: () {
                    log('message');
                    OpenContainer(
                      closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      closedElevation: 0,
                      closedColor: Colors.transparent,
                      openColor: Colors.transparent,
                      transitionDuration: const Duration(milliseconds: 500),
                      closedBuilder: (context, openContainer) =>
                          const MainApp(),
                      openBuilder: (context, _) => DetailsPage(
                        car: valuesDataColors[index],
                        index: index,
                      ),
                    );
                  },
                  child: valuesWidget[index],
                ),
              ),
            ),
            // SizedBox(
            //   // height: MediaQuery.of(context).size.height * 0.58,
            //   height: MediaQuery.of(context).size.height * 2,
            //   child: PageView.builder(
            //     clipBehavior: Clip.none,
            //     controller: PageController(
            //       viewportFraction: 1,
            //     ),
            //     itemBuilder: (context, index) => valuesWidget[index],
            //     itemCount: valuesWidget.length,
            //   ),
            // ),

            // CardSlider(
            //   cards: valuesWidget,
            //   cardWidth: MediaQuery.of(context).size.width,
            //   containerHeight: MediaQuery.of(context).size.height,
            //   cardHeight: MediaQuery.of(context).size.height,
            //   // cardHeightOffset: 0,
            // )
          ],
        ),
      ),
    );
  }
}
