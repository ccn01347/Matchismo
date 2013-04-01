//
//  CardGameViewController.m
//  Matchismo
//
//  Created by SteveLai on 13年3月5日.
//  Copyright (c) 2013年 SteveLai. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"     //Add呢個包埋個Deck
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultOfLastFlipLabel;

- (IBAction)deal:(id)sender;

- (IBAction)changeCardMode:(UISegmentedControl *)sender;

@end

@implementation CardGameViewController


-(CardMatchingGame *)game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
        [self changeCardMode:self.cardModeControl];
    }
    
    
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void)updateUI{
    
    
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultOfLastFlipLabel.text = self.game.descriptionOfLastFlip;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
        [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        self.flipCount++;
        [self updateUI];
    
}


- (void)viewDidUnload {
    [self setResultOfLastFlipLabel:nil];
    [self setCardModeControl:nil];
    [self setCardModeControl:nil];
    [super viewDidUnload];
}
- (IBAction)deal:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
    self.cardModeControl.enabled = YES;
    self.resultOfLastFlipLabel.text = @"Let Start";
}

- (IBAction)changeCardMode:(UISegmentedControl *)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            self.game.numberOfMatchingCards = 2;
            break;
        case 1:
            self.game.numberOfMatchingCards = 3;
            
        default:
            self.game.numberOfMatchingCards = 2;
            break;
    }
}



@end
