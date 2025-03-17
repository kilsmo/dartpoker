import 'package:test/test.dart';
import 'package:dartpoker/hand_rank.dart';

bool areHandsEqual(HandRank expected, HandRank actual) {
  return expected.compareTo(actual) == 0;
}

bool isBetterThan(HandRank rank1, HandRank rank2) {
  return rank1.compareTo(rank2) > 0;
}

bool isWorseThan(HandRank rank1, HandRank rank2) {
  return rank1.compareTo(rank2) < 0;
}


void main() {
  group('highCard', () {
    test('should return highCard that is 5 cards sorted', () {
      var expected = HandRank(
        HandStrength.highCard,
        [Rank.ace, Rank.king, Rank.nine, Rank.six, Rank.two]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.six),
        Card(Suit.diamonds, Rank.nine),
        Card(Suit.clubs, Rank.ace),
        Card(Suit.clubs, Rank.king),
        Card(Suit.clubs, Rank.two)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });

    test('should return highCard 7 high if lowest posible hand', () {
      var expected = HandRank(
        HandStrength.highCard,
        [Rank.seven, Rank.five, Rank.four, Rank.three, Rank.two]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.five),
        Card(Suit.diamonds, Rank.seven),
        Card(Suit.clubs, Rank.two),
        Card(Suit.clubs, Rank.four),
        Card(Suit.clubs, Rank.three)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });

  });

  group('flush', () {
    test('should return flush that is 5 cards sorted', () {
      var expected = HandRank(
        HandStrength.flush,
        [Rank.ace, Rank.king, Rank.nine, Rank.six, Rank.two]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.six),
        Card(Suit.clubs, Rank.nine),
        Card(Suit.clubs, Rank.ace),
        Card(Suit.clubs, Rank.king),
        Card(Suit.clubs, Rank.two)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });
  });

  group('straight', () {
    test('should return straight that is 9 high', () {
      var expected = HandRank(
        HandStrength.straight,
        [Rank.nine]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.six),
        Card(Suit.spades, Rank.nine),
        Card(Suit.clubs, Rank.eight),
        Card(Suit.clubs, Rank.seven),
        Card(Suit.clubs, Rank.five)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });

    test('should return straight that is 5 high', () {
      var expected = HandRank(
        HandStrength.straight,
        [Rank.five]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ace),
        Card(Suit.spades, Rank.four),
        Card(Suit.clubs, Rank.five),
        Card(Suit.clubs, Rank.two),
        Card(Suit.clubs, Rank.three)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });

  });

  group('straightFlush', () {
    test('should return straightFlush that is 9 high', () {
      var expected = HandRank(
        HandStrength.straightFlush,
        [Rank.nine]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.six),
        Card(Suit.clubs, Rank.nine),
        Card(Suit.clubs, Rank.eight),
        Card(Suit.clubs, Rank.seven),
        Card(Suit.clubs, Rank.five)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });
  });

  group('royalFlush', () {
    test('should return royalFlush', () {
      var expected = HandRank(
        HandStrength.royalFlush,
        []
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.clubs, Rank.queen),
        Card(Suit.clubs, Rank.ace),
        Card(Suit.clubs, Rank.king),
        Card(Suit.clubs, Rank.jack)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });
  });

  group('onePair', () {
    test('should return pair of tens', () {
      var expected = HandRank(
        HandStrength.onePair,
        [Rank.ten, Rank.ace, Rank.king, Rank.jack]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.clubs, Rank.ace),
        Card(Suit.clubs, Rank.king),
        Card(Suit.clubs, Rank.jack)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });

    test('should return pair of aces', () {
      var expected = HandRank(
        HandStrength.onePair,
        [Rank.ace, Rank.king, Rank.jack, Rank.ten]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ace),
        Card(Suit.clubs, Rank.ace),
        Card(Suit.clubs, Rank.king),
        Card(Suit.clubs, Rank.jack)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });

    test('should return pair of sevens', () {
      var expected = HandRank(
        HandStrength.onePair,
        [Rank.seven, Rank.jack, Rank.ten, Rank.nine]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.nine),
        Card(Suit.clubs, Rank.seven),
        Card(Suit.spades, Rank.seven),
        Card(Suit.clubs, Rank.jack)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });

    test('should return pair of jacks', () {
      var expected = HandRank(
        HandStrength.onePair,
        [Rank.jack, Rank.ten, Rank.nine, Rank.seven]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.nine),
        Card(Suit.clubs, Rank.seven),
        Card(Suit.spades, Rank.jack),
        Card(Suit.clubs, Rank.jack)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });

  });

  group('threeOfAKind', () {
    test('should return three of a kind of tens', () {
      var expected = HandRank(
        HandStrength.threeOfAKind,
        [Rank.ten, Rank.queen, Rank.jack]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.hearts, Rank.ten),
        Card(Suit.diamonds, Rank.jack),
        Card(Suit.clubs, Rank.queen)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });
  });

  group('two pair', () {
    test('should return two pairs', () {
      var expected = HandRank(
        HandStrength.twoPair,
        [Rank.jack, Rank.ten, Rank.queen]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.hearts, Rank.jack),
        Card(Suit.diamonds, Rank.jack),
        Card(Suit.clubs, Rank.queen)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });
  });

  group('four of a kind', () {
    test('should return four of a kind', () {
      var expected = HandRank(
        HandStrength.fourOfAKind,
        [Rank.ten, Rank.queen]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.hearts, Rank.ten),
        Card(Suit.diamonds, Rank.ten),
        Card(Suit.clubs, Rank.queen)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });
  });

  group('full house', () {
    test('should return full house', () {
      var expected = HandRank(
        HandStrength.fullHouse,
        [Rank.ten, Rank.queen]
      );
      var actual = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.hearts, Rank.ten),
        Card(Suit.diamonds, Rank.queen),
        Card(Suit.clubs, Rank.queen)
      ]);
      expect(true, areHandsEqual(expected, actual));
    });
  });

  group('compare HandRanks', () {
    test('should return true since both are the same full house', () {
      var rank1 = HandRank(
        HandStrength.fullHouse,
        [Rank.ten, Rank.queen]
      );
      var rank2 = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.hearts, Rank.ten),
        Card(Suit.diamonds, Rank.queen),
        Card(Suit.clubs, Rank.queen)
      ]);
      expect(true, areHandsEqual(rank1, rank2));
    });

    test('should return true since the first rank is biggest', () {
      var rank1 = HandRank(
        HandStrength.fullHouse,
        [Rank.ten, Rank.queen]
      );
      var rank2 = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.hearts, Rank.ten),
        Card(Suit.diamonds, Rank.jack),
        Card(Suit.clubs, Rank.jack)
      ]);
      expect(true, isBetterThan(rank1, rank2));
    });

    test('should return true since the second rank is biggest', () {
      var rank1 = HandRank(
        HandStrength.fullHouse,
        [Rank.ten, Rank.queen]
      );
      var rank2 = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.hearts, Rank.ten),
        Card(Suit.diamonds, Rank.king),
        Card(Suit.clubs, Rank.king)
      ]);
      expect(true, isWorseThan(rank1, rank2));
    });

    test('should return true since the first handStrength is biggest', () {
      var rank1 = HandRank(
        HandStrength.fullHouse,
        [Rank.ten, Rank.queen]
      );
      var rank2 = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.hearts, Rank.queen),
        Card(Suit.diamonds, Rank.jack),
        Card(Suit.clubs, Rank.jack)
      ]);
      expect(true, isBetterThan(rank1, rank2));
    });

    test('should return true since the second handStrength is biggest', () {
      var rank1 = HandRank(
        HandStrength.twoPair,
        [Rank.queen, Rank.jack, Rank.ace]
      );
      var rank2 = HandRank.create([
        Card(Suit.clubs, Rank.ten),
        Card(Suit.spades, Rank.ten),
        Card(Suit.hearts, Rank.ten),
        Card(Suit.diamonds, Rank.jack),
        Card(Suit.clubs, Rank.jack)
      ]);
      expect(true, isWorseThan(rank1, rank2));
    });

  });

}
