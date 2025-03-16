/// Represents a card's suit.
enum Suit {
  diamonds,
  spades,
  hearts,
  clubs
}

/// Represents a card's rank, from two to ace.
enum Rank implements Comparable<Rank> {
  two(2),
  three(3),
  four(4),
  five(5),
  six(6),
  seven(7),
  eight(8),
  nine(9),
  ten(10),
  jack(11),
  queen(12),
  king(13),
  ace(14);

  final int value;
  const Rank(this.value);

  @override
  int compareTo(Rank other) => value.compareTo(other.value);
}

/// Represents the HandStrength, from highCard to royalFlush.
enum HandStrength implements Comparable<HandStrength> {
  highCard(0),
  onePair(1),
  twoPair(2),
  threeOfAKind(3),
  straight(4),
  flush(5),
  fullHouse(6),
  fourOfAKind(7),
  straightFlush(8),
  royalFlush(9);

  final int value;
  const HandStrength(this.value);

  @override
  int compareTo(HandStrength other) => value.compareTo(other.value);
}

/// Represents a card, with suit and rank.
class Card {
  final Suit suit;
  final Rank rank;

  Card(this.suit, this.rank);
}

/// Represents the HandRank, that consists
/// of the HandStrength, and a list of ranks,
/// that is, the values of the cards that
/// defines the minor strength of a hand,
/// for a full house kings over aces, ranks
/// would be [Rank.king, Rank.ace].
/// The HandStrength would be HandStrength.fullHouse
class HandRank implements Comparable<HandRank> {
  final HandStrength handStrength;
  final List<Rank> ranks;

  HandRank(this.handStrength, this.ranks);

  @override
  int compareTo(HandRank other) {
    if (handStrength != other.handStrength) return handStrength.compareTo(other.handStrength);
    for (int i = 0; i < ranks.length; i++) {
      if (ranks[i] != other.ranks[i]) {
        return ranks[i].compareTo(other.ranks[i]);
      }
    }
    return 0;
  }
  /// Check if the poker hand represents a flush.
  static bool isFlush(List<Card> cards) {
    Suit suit = cards[0].suit;
    for (int i = 1; i < 5; i++) {
      if (suit != cards[i].suit) {
        return false;
      }
    }
    return true;
  }

  /// Check if the poker hand is a straight.
  static bool isStraight(List<Rank> ranks) {
    return ranks[0].index == ranks[4].index + 4 ||
      (ranks[0] == Rank.ace && ranks[1] == Rank.five);
  }

  /// Gets the rank (highest card in the straight) of a
  /// straight. The in parameter ranks must be the
  /// sorted ranks of a straight.
  /// [Rank.ace, Rank.five, Rank.four, Rank.three, Rank.two]
  /// Will return something like Rank.five or Rank.Ace.
  static Rank getStraightRank(List<Rank> ranks) {
    return ranks[0] == Rank.ace && ranks[1] == Rank.five ?
      Rank.five :
      ranks[0];
  }

  /// Creates a new list of cards, where they are sorted in Rank order,
  /// with Rank.ace highest and Rank.two lowest.
  static List<Rank> getSortedRanks(List<Card> cards) {
    List<Rank> ranks = cards.map((card) { return card.rank; }).toList();
    ranks.sort((a, b) => a.index - b.index);
    ranks = ranks.reversed.toList();
    return ranks;
  }

  /// Counts the number of different ranks in the hand.
  /// For a flush, it would be 5, for a pair, 4, for
  /// two pairs 3, for a straight 5, for a full house 2.
  static int getRankCount(List<Rank> ranks) {
    return ranks.toSet().length;
  }

  /// Creates a hand that is fourOfAKind or fullHouse strength,
  /// since we already know that the rankCount is 2.
  static HandRank createFourFull(List<Rank> ranks) {
    if (ranks[0] == ranks[3]) {
      return HandRank(HandStrength.fourOfAKind, [ranks[0], ranks[4]]);
    } else if (ranks[1] == ranks[4]) {
      return HandRank(HandStrength.fourOfAKind, [ranks[4], ranks[0]]);
    } else if (ranks[0] == ranks[2]) {
      return HandRank(HandStrength.fullHouse, [ranks[0], ranks[4]]);
    }
    return HandRank(HandStrength.fullHouse, [ranks[4], ranks[0]]);
  }

  /// Creates a HandRank that is a threeOfAKind or twoPair,
  /// since we already know that there are 3 different rank
  /// values.
  static HandRank createThreeTwo(List<Rank> ranks) {
    if (ranks[0] == ranks[2]) {
      return HandRank(
        HandStrength.threeOfAKind,
        [ranks[0], ranks[3], ranks[4]]
      );
    } else if (ranks[1] == ranks[3]) {
      return HandRank(
        HandStrength.threeOfAKind,
        [ranks[1], ranks[0], ranks[4]]
      );
    } else if (ranks[2] == ranks[4]) {
      return HandRank(
        HandStrength.threeOfAKind,
        [ranks[2], ranks[0], ranks[1]]
      );
    } else if (ranks[0] == ranks[1] && ranks[2] == ranks[3]) {
      return HandRank(
        HandStrength.twoPair,
        [ranks[0], ranks[2], ranks[4]]
      );
    } else if (ranks[0] == ranks[1] && ranks[3] == ranks[4]) {
      return HandRank(
        HandStrength.twoPair,
        [ranks[0], ranks[3], ranks[2]]
      );
    }
    return HandRank(
      HandStrength.twoPair,
      [ranks[1], ranks[3], ranks[0]]
    );
  }

  /// Creates a HandRank that is a pair,
  /// since we already know that there are 4 different rank
  /// values.
  static HandRank createPair(List<Rank> ranks) {
    if (ranks[0] == ranks[1]) {
      return HandRank(
        HandStrength.onePair,
        [ranks[0], ranks[2], ranks[3], ranks[4]]
      );
    } else if (ranks[1] == ranks[2]) {
      return HandRank(
        HandStrength.onePair,
        [ranks[1], ranks[0], ranks[3], ranks[4]]
      );
    } else if (ranks[2] == ranks[3]) {
      return HandRank(
        HandStrength.onePair,
        [ranks[2], ranks[0], ranks[1], ranks[4]]
      );
    }
    return HandRank(
      HandStrength.onePair,
      [ranks[3], ranks[0], ranks[1], ranks[2]]
    );
  }

  /// Creates a HandRank that is a flush or highCard,
  /// since we already know that there are 5 different rank
  /// values.
  static HandRank createFlushStraightHighCard(List<Rank> ranks, bool flush) {
    bool straight = isStraight(ranks);
    if (straight && flush) {
      Rank straightRank = getStraightRank(ranks);
      if (straightRank == Rank.ace) {
        return HandRank(HandStrength.royalFlush, []);
      }
      return HandRank(HandStrength.straightFlush, [straightRank]);
    }
    if (flush) return HandRank(HandStrength.flush, ranks);
    if (straight) return HandRank(HandStrength.straight, [getStraightRank(ranks)]);
    return HandRank(HandStrength.highCard, ranks);
  }

  /// Creates the HandRank for the hand.
  static HandRank create(List<Card> cards) {
    bool flush = isFlush(cards);
    List<Rank> ranks = getSortedRanks(cards);
    switch (getRankCount(ranks)) {
      case 2:
        return createFourFull(ranks);
      case 3:
        return createThreeTwo(ranks);
      case 4:
        return createPair(ranks);
    }
    return createFlushStraightHighCard(ranks, flush);
  }

}
