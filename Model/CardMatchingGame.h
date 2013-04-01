//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by SteveLai on 13年3月29日.
//  Copyright (c) 2013年 SteveLai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
-(void)flipCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;


@property (nonatomic, readonly/*即係冇ｓｅｔｔｅｒ只有ｇｅｔｔｅｒ*/)int score;
@property (nonatomic, readonly) NSString *descriptionOfLastFlip;

@property (nonatomic)int numberOfMatchingCards;

@end
