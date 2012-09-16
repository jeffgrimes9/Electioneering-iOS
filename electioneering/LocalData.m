//
//  LocalData.m
//  electioneering
//
//  Created by Jeff Grimes on 9/15/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import "LocalData.h"

static LocalData *sharedInstance = nil;

@implementation LocalData

+ (id)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[LocalData alloc] init];
    }
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        self.issues = [[NSMutableArray alloc] init];
        self.selectionStates = [[NSMutableArray alloc] init];
        self.allActors = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 12; i++) {
            [self.selectionStates addObject:@"title"];
        }
    }
    return self;
}

- (void)changeSelectionStateAtIndex:(int)index {
    NSString *selectionState = [self.selectionStates objectAtIndex:index];
    [self.selectionStates removeObjectAtIndex:index];
    if ([selectionState isEqualToString:@"title"]) {
        [self.selectionStates insertObject:@"details" atIndex:index];
    } else {
        [self.selectionStates insertObject:@"title" atIndex:index];
    }
}

- (void)resetSelectionStates {
    for (int i = 0; i < self.selectionStates.count; i++) {
        [self.selectionStates removeObjectAtIndex:i];
        [self.selectionStates insertObject:@"title" atIndex:i];
    }
}

- (void)clearIssues {
    self.issues = [[NSMutableArray alloc] init];
}

@end