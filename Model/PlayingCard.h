//
//  PlayingCard.h
//  Matchismo
//
//  Created by SteveLai on 13年3月29日.
//  Copyright (c) 2013年 SteveLai. All rights reserved.
//

#import "Card.h"

@interface PlayingCard :Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;


@end
