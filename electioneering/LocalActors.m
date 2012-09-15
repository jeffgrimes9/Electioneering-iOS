//
//  LocalActors.m
//  electioneering
//
//  Created by Jeff Grimes on 9/15/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import "LocalActors.h"

static LocalActors *sharedInstance = nil;

@implementation LocalActors

+ (id)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[LocalActors alloc] init];
    }
    return sharedInstance;
}

@end
