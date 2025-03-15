import 'dart:async';
import 'dart:io';

import 'package:dartpoker/dartpoker.dart' as dartpoker;

enum Suit { diamonds, spades, hearts, clubs }

enum Rank {
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
  ace
}

enum HandStrength {
  highCard,
  onePair,
  twoPair,
  threeOfAKind,
  straight,
  flush,
  fullHouse,
  fourOfAKind,
  straightFlush,
  royalFlush
}

class Card {
  Card(this.suit, this.rank);

  Suit suit;
  Rank rank;
}

class Hand {
  Hand(this.cards);

  List<Card> cards;
}

extension on Rank {
  int compareTo(Rank other) => index.compareTo(other.index);
}

class HandRank {
  HandRank(Hand hand) {
    if (hand.cards.length == 5) {
      hand.cards.sort((a, b) => a.rank.compareTo(b.rank));
    }
    getHandStrength(hand);
  }

  bool isFlush(Hand hand) {
    Suit suit = hand.cards[0].suit;
    for (int i = 1; i < 5; i++) {
      if (hand.cards[i].suit != suit) {
        return false;
      }
    }
    return true;
  }

  bool isStraight(Hand hand) {
    if (hand.cards[0].rank.index + 4 == hand.cards[4].rank.index) {
      return true;
    }
    return hand.cards[0].rank == Rank.ace && hand.cards[1].rank == Rank.four;
  }

  void getHandStrength3(Hand hand) {
    // twoPair, threeOfAKind
  }

  void getHandStrength4(Hand hand) {
    handStrength = HandStrength.onePair;

    int pairIdx = 0;

    for (int i = 0; i < 4; i++) {
      if (hand.cards[i] == hand.cards[i + 1]) {
        pairIdx = i;
      }
    }

    ranks.add(hand.cards[pairIdx].rank);

    for (int i = 0; i < 5; i++) {
      if (i != pairIdx && i != pairIdx + 1) {
        ranks.add(hand.cards[i].rank);
      }
    }
  }

  void getHandStrength5(Hand hand) {
    bool flush = isFlush(hand);
    bool straight = isStraight();
    bool royal = flush && straight && hand.cards[0].rank == Rank.ace;
    if (royal) {
      handStrength = HandStrength.royalFlush;
    } else if (flush && straight) {
      handStrength = HandStrength.straightFlush;
      ranks.add(hand.cards[0].rank);
    } else if (flush) {
      handStrength = HandStrength.flush;
      for (int i = 0; i < 5; i++) {
        ranks.add(hand.cards[i].rank);
      }
    } else if (straight) {
      handStrength = HandStrength.straight;
      ranks.add(hand.cards[0].rank);
    } else {
      handStrength = HandStrength.straight;
      for (int i = 0; i < 5; i++) {
        ranks.add(hand.cards[i].rank);
      }
    }
  }

  HandStrength getHandStrength(Hand hand) {
    switch (getNrOfDifferentRanks(hand)) {
      case 2:
        return getHandStrength2(hand);
      case 3:
        return getHandStrength3(hand);
      case 4:
        return getHandStrength4(hand);
      default:
        return getHandStrength5(hand);
    }
  }

  int getNrOfDifferentRanks(Hand hand) {
    int differentRanks = 1;
    for (int i = 0; i < 4; i++) {
      if (hand.cards[i] != hand.cards[i + 1]) {
        differentRanks++;
      }
    }
    return differentRanks;
  }

  HandStrength handStrength = HandStrength.highCard;
  List<Rank> ranks = [];
}

void main(List<String> arguments) {
  print('Hello world: ${dartpoker.calculate()}!');
}
