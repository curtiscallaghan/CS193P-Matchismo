//
//  Card.h
//  Matchismo
//
//  Created by Curtis Callaghan on 8/8/14.
//  Copyright (c) 2014 curtis. All rights reserved.
//
@import Foundation;
@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray*)otherCards;

@end
