//
//  Card.m
//  Matchismo
//
//  Created by SteveLai on 13年3月5日.
//  Copyright (c) 2013年 SteveLai. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card


-(int)match:(NSArray *)otherCards{
    int score = 1;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}


@end
