//
//  LocalData.h
//  electioneering
//
//  Created by Jeff Grimes on 9/15/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalData : NSObject

@property (nonatomic, retain) NSString *localActorOne;
@property (nonatomic, retain) NSString *localActorTwo;
@property (nonatomic, retain) NSMutableArray *issues;
@property (nonatomic, retain) NSMutableArray *selectionStates;
@property (nonatomic, retain) NSMutableArray *allActors;

+ (id)sharedInstance;
- (void)changeSelectionStateAtIndex:(int)index;
- (void)resetSelectionStates;

@end