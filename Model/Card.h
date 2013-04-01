//
//  Card.h
//  Matchismo
//
//  Created by SteveLai on 13年3月5日.
//  Copyright (c) 2013年 SteveLai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic)NSString *contents;

@property (nonatomic, getter = isFaceUp)BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

-(int)match:(NSArray *)otherCards;




@end
