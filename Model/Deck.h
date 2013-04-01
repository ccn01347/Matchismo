//
//  Deck.h
//  Matchismo
//
//  Created by SteveLai on 13年3月5日.
//  Copyright (c) 2013年 SteveLai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
