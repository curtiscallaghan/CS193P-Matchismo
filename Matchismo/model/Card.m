//
//  Card.m
//  Matchismo
//
//  Created by Curtis Callaghan on 8/8/14.
//  Copyright (c) 2014 curtis. All rights reserved.
//

#import "Card.h"

@interface Card()
@end

@implementation Card

- (int)match:(NSArray*)otherCards
{
    int score = 0;

    for (Card *card in otherCards) {
        if ( [self.contents isEqualToString:card.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
