//
//  PlayingCard.m
//  Matchismo
//
//  Created by Curtis Callaghan on 8/9/14.
//  Copyright (c) 2014 curtis. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard ()
@end

@implementation PlayingCard

- (NSString*)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString*)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRanks
{
    return [[self rankStrings] count] -1;
}

+ (NSArray *)validSuits
{
    return @[@"♠️",@"♥️",@"♦️",@"♣️"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",
             @"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        }
        else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    else if ([otherCards count] == 2) {
        for (PlayingCard *otherCard in otherCards) {
            if (otherCard.rank == self.rank) {
                score += 4;
            }
            else if ([otherCard.suit isEqualToString:self.suit]) {
                score += 1;
            }
        }
    }
    
    return score;
}

@end
