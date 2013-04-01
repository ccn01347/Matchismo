//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by SteveLai on 13年3月29日.
//  Copyright (c) 2013年 SteveLai. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(id)init{

    self = [super init];   //自己ｓｅｔ個ｉｎｉｔ
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
    
}


@end
