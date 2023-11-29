import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../services/CardGen.dart';
import 'package:sizer/sizer.dart';

class SingleGameScreen extends StatefulWidget {
  final int level;
  final int symbols;
  const SingleGameScreen(
      {super.key, required this.symbols, required this.level});

  @override
  SingleGameScreenState createState() => SingleGameScreenState();
}

class SingleGameScreenState extends State<SingleGameScreen> {
  int _numOfSquaresInTopRow = 0;
  int _numOfSquaresInBottomRow = 0;
  int angleTopCard = 180;
  int angleBottonCard = 0;
  bool isWin = false;
  bool isLost = false;
  Map<int, List<String>> shuffledCardMap = {};
  int timeForGame = 5;
  late Timer _timer;
  ValueNotifier<int> _timerValue = ValueNotifier<int>(5);
  List<int> timeLevelList = [150, 250, 350, 450, 600];
  double sizeCard = 15.w;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (timeForGame <= 0) {
        timer.cancel();
        if (isWin == false) {
          isLost = true;
        }
      } else {
        timeForGame--;
        _timerValue.value = timeForGame;
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr ';
  }

  @override
  void initState() {
    setTimer();

    startTimer();

    _numOfSquaresInTopRow = (widget.symbols / 2).ceil();
    _numOfSquaresInBottomRow = (widget.symbols / 2).floor();

    shuffledCardMap = CardGen().getCardsList(widget.symbols);
  }

  setTimer() {
    timeForGame = timeLevelList[widget.symbols - 4];
    timeForGame = timeForGame ~/ widget.level;
    _timerValue = ValueNotifier<int>(timeForGame);
  }

  _onSquarePressed(int index, int cardLevelOnScreen) {
    if (isWin == false && isLost == false) {
      var cardNumberPressed =
          shuffledCardMap.values.elementAt(cardLevelOnScreen)[index];
      int opponentCardLevelOnScreen = 0;
      if (cardLevelOnScreen == 0) {
        opponentCardLevelOnScreen = 1;
      }
      if (shuffledCardMap.values
          .elementAt(opponentCardLevelOnScreen)
          .contains(cardNumberPressed)) {
        if (shuffledCardMap.length <= 3) {
          isWin = true;
          _timer.cancel();
          _timerValue.dispose();
        }
        if (shuffledCardMap.length >= 4) {
          shuffledCardMap
              .removeWhere((key, value) => key == shuffledCardMap.keys.first);
          shuffledCardMap
              .removeWhere((key, value) => key == shuffledCardMap.keys.first);
        }

        setState(() {});
      } else {
        timeForGame = timeForGame - 5;
        if (timeForGame <= 0) {
          timeForGame = 0;
        }
        _timerValue.value = timeForGame;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/background_gamescreen.png"),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                height: 10.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                          fit: BoxFit.fitHeight,
                          "assets/images/button_arrow.png"),
                    ),
                    Stack(alignment: AlignmentDirectional.center, children: [
                      Image.asset(
                          fit: BoxFit.fitHeight,
                          "assets/images/button_time.png"),
                      SizedBox(
                        width: 24.w,
                        child: ValueListenableBuilder<int>(
                          valueListenable: _timerValue,
                          builder:
                              (BuildContext context, int value, Widget? child) {
                            return Text(
                              formatTime(value),
                              style: TextStyle(fontSize: 8.w),
                            );
                          },
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              twoCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget popUpLost() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 50.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/images/pop_up.png"),
            ),
          ),
          child: Center(
            child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.sp,
                ),
                "loos"),
          ),
        ),
      ]),
    );
  }

  Widget popUpWin() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 54.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/images/pop_up.png"),
            ),
          ),
          child: Center(
            child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.sp,
                ),
                "winText"),
          ),
        ),
      ]),
    );
  }

  Widget twoCards() {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Column(children: [
        cardGame(shuffledCardMap.values.elementAt(0), 0),
        Container(
          height: 3.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image:
                  AssetImage("assets/images/background_gamescreen_strip.png"),
            ),
          ),
        ),
        cardGame(shuffledCardMap.values.elementAt(1), 1),
      ]),
      isWin ? popUpWin() : const Stack(),
      ValueListenableBuilder<int>(
        valueListenable: _timerValue,
        builder: (BuildContext context, int value, Widget? child) {
          return value < 1 ? popUpLost() : const Stack();
        },
      ),
    ]);
  }

  Widget cardGame(List<String>? cardNameList, int cardLevelOnScreen) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 40.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _numOfSquaresInTopRow,
                  (index) => GestureDetector(
                    onTap: () => _onSquarePressed(index, cardLevelOnScreen),
                    child: Transform.rotate(
                      angle: cardLevelOnScreen == 0 ? 0 : 0,
                      child: Transform.scale(
                        scale: 1 + Random().nextDouble(),
                        child: Container(
                          width: sizeCard,
                          height: sizeCard,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(
                                  "assets/images/${cardNameList?[index]}.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _numOfSquaresInBottomRow,
                  (index) => GestureDetector(
                    onTap: () => _onSquarePressed(
                        index + _numOfSquaresInTopRow, cardLevelOnScreen),
                    child: Transform.rotate(
                      angle: cardLevelOnScreen == 0 ? 0 : 0,
                      child: Transform.scale(
                        scale: 0.8 + Random().nextDouble(),
                        child: Container(
                          width: sizeCard,
                          height: sizeCard,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(
                                  "assets/images/${cardNameList?[index + _numOfSquaresInTopRow]}.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (isWin == false) {
      _timer.cancel();
      _timerValue.dispose();
    }
    super.dispose();
  }
}
