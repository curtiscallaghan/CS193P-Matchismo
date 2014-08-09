//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Curtis Callaghan on 8/8/14.
//  Copyright (c) 2014 curtis. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardsDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@end

@implementation CardGameViewController


-(Deck *)deck
{
    if(!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck*)createDeck
{
    return [[PlayingCardsDeck alloc] init];
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flip count changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if ( [[sender currentTitle] length]) {
    
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else {
        
        Card* card = [self.deck drawRandomCard];
        
        if (card) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:[card contents]
                    forState:UIControlStateNormal];
        }
        else {
            [sender setHidden:YES];
            return;
        }
    }
    
    self.flipCount++;
}

@end