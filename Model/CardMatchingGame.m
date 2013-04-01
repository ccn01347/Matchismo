//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by SteveLai on 13年3月29日.
//  Copyright (c) 2013年 SteveLai. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) NSString *descriptionOfLastFlip;

@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{ //將Card save入self.cards[i]
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            }else{
                self.cards[i] = card;
            }
        }    
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4


-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            NSMutableArray *otherCards = [[NSMutableArray alloc]init];
            NSMutableArray *otherContents = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.unplayable) {
                    [otherCards addObject:otherCard];
                    [otherContents addObject:otherCard.contents];
                }
            }
            if ([otherCards count] < self.numberOfMatchingCards - 1) {
                self.descriptionOfLastFlip = [NSString stringWithFormat:@"Filpped up %@", card.contents];
            }else {
                int matchScore = [card match:otherCards];
                if(matchScore) {
                    card.unplayable = YES;
                    for (Card *otherCard in otherCards){
                        otherCard.unplayable = YES;
                    }
                    self.score += matchScore * MATCH_BONUS;
                    self.descriptionOfLastFlip = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",
                                                  card.contents,
                                                  [otherContents componentsJoinedByString:@" & "],
                                                  matchScore * MATCH_BONUS];;
                }else {
                    for (Card *otherCard in otherCards){
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.descriptionOfLastFlip = [NSString stringWithFormat:@"%@ & %@ don't Match! %d points penalty!", card.contents, [otherContents componentsJoinedByString:@" & "], MISMATCH_PENALTY];
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}


/*
    Card *card = [self cardAtIndex:index];
    Card *otherCard;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.descriptionOfLastFlip = [NSString stringWithFormat:@"Flipped up %@!", card.contents];
            for (otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BOUNS;
                        self.descriptionOfLastFlip = [NSString stringWithFormat:@"Matched %@ & %@ for %d points!", otherCard.contents, card.contents, matchScore * MATCH_BOUNS];
                        
                    }else{
                        otherCard.faceUp = NO;
                        self.score -= MISMARCH_PENALTY;
                        self.descriptionOfLastFlip = [NSString stringWithFormat:@"%@ & %@ don't match! %d poionts penalty!", otherCard.contents, card.contents, matchScore * MISMARCH_PENALTY];
    
                    }
                    break;
                }
            }
            self.score -=FLIP_COST;

        }
        card.faceUp = !card.isFaceUp;
    }

*/


@synthesize numberOfMatchingCards = _numberOfMatchingCards;

-(int)numberOfMatchingCards{
    if (!_numberOfMatchingCards) _numberOfMatchingCards = 2;
    return _numberOfMatchingCards;
}

- (void)setNumberOfMatchingCards:(int)numberOfMatchingCards
{
    if (numberOfMatchingCards < 2) _numberOfMatchingCards = 2;
    else if (numberOfMatchingCards > 3) _numberOfMatchingCards = 3;
    else _numberOfMatchingCards = numberOfMatchingCards;
}












@end
