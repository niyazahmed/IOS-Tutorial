//
//  NSObject_CardMatchingGame.h
//  Matchismo
//
//  Created by Niyaz on 11/6/14.
//  Copyright (c) 2014 Niyaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject
enum category {
    twoCard ,threeCard
};

//designated init
-(instancetype) initWithCardCount:(NSInteger) count usingDeck:(Deck *) deck;
-(void) chooseCardAtIndex:(NSInteger)index;
-(Card *) cardAtIndex:(NSInteger) index;
@property(nonatomic,readonly) NSInteger score;
@property(nonatomic) enum category gameType;
@end
