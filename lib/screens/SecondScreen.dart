import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'SingleGameScreen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    Key? key,
  }) : super(key: key);

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  Color textColor = const Color.fromRGBO(255, 255, 255, 1);
  int levelNumber = 1;
  int symbolsNumber = 4;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/images/background_mainscreen.png"),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: SizedBox(
                    width: 40.h,
                    height: 21.h,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.h),
                        image: const DecorationImage(
                          fit: BoxFit.fitHeight,
                          image:
                              AssetImage("assets/images/back_for_choose.png"),
                        ),
                      ),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      style: TextStyle(
                                        fontSize: 4.h,
                                      ),
                                      "Level"),
                                  Text(
                                      style: TextStyle(
                                        fontSize: 4.h,
                                      ),
                                      "Symbol"),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [levelCounter(), symbolsCounter()],
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  height: 7.h,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) {
                            return SingleGameScreen(
                                symbols: symbolsNumber, level: levelNumber);
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage("assets/images/button_play.png"),
                        ),
                      ),
                      child: Center(
                        child: Text(
                            style: TextStyle(
                              fontSize: 4.h,
                            ),
                            "Play"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void _incrementLevelNumber() {
    if (levelNumber < 5) {
      setState(() {
        levelNumber++;
      });
    }
  }

  void _decrementLevelNumber() {
    if (levelNumber > 1) {
      setState(() {
        levelNumber--;
      });
    }
  }

  void _incrementSymbolsNumber() {
    if (symbolsNumber < 8) {
      setState(() {
        symbolsNumber++;
      });
    }
  }

  void _decrementSymbolsNumber() {
    if (symbolsNumber > 4) {
      setState(() {
        symbolsNumber--;
      });
    }
  }

  Widget levelCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoButton(
          onPressed: _decrementLevelNumber,
          child: Text(
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 4.h,
              ),
              '-'),
        ),
        SizedBox(
          width: 4.w,
          child: Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 4.h,
              ),
              '$levelNumber'),
        ),
        CupertinoButton(
          onPressed: _incrementLevelNumber,
          child: Text(
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 4.h,
              ),
              '+'),
        ),
      ],
    );
  }

  Widget symbolsCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoButton(
          onPressed: _decrementSymbolsNumber,
          child: Text(
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 4.h,
              ),
              '-'),
        ),
        SizedBox(
          width: 4.w,
          child: Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 4.h,
              ),
              '$symbolsNumber'),
        ),
        CupertinoButton(
          onPressed: _incrementSymbolsNumber,
          child: Text(
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 4.h,
              ),
              '+'),
        ),
      ],
    );
  }
}
