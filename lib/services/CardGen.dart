import 'dart:math';

class CardGen {
  Map<int, List<String>> getCardsList(int numberOfSymbolsOnCard) {
    List<int> numbers = List.generate(100, (index) => index + 1);
    List<String> symbols = numbers.map((e) => e.toString()).toList();

    List<List<int>> cards = [];

    int n = numberOfSymbolsOnCard - 1;

    for (int i = 0; i < n + 1; i++) {
      cards.add([1]);
      for (int j = 0; j < n; j++) {
        cards[i].add((j + 1) + (i * n) + 1);
      }
    }

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        cards.add([i + 2]);
        for (int k = 0; k < n; k++) {
          int val = (n + 1 + n * k + (i * k + j) % n) + 1;
          cards[cards.length - 1].add(val);
        }
      }
    }

    for (List<int> card in cards) {
      card.shuffle();
    }

    Map<int, List<String>> cardMap = {};
    for (var i = 0; i < cards.length; i++) {
      var card = cards[i];

      cardMap[i + 1] =
          card.map((symbolIndex) => symbols[symbolIndex - 1]).toList();
    }
    Random random = Random();
    List<int> keys = cardMap.keys.toList();
    keys.shuffle(random);

    Map<int, List<String>> shuffledCardMap = {};
    for (var key in keys) {
      shuffledCardMap[key] = cardMap[key]!;
    }
    return shuffledCardMap;
  }
}
