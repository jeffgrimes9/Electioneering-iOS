//
//  ElectioneeringIssue.m
//  electioneering
//
//  Created by Jeff Grimes on 9/15/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import "ElectioneeringIssue.h"

@implementation ElectioneeringIssue

- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.issueName = [dict objectForKey:@"issueName"];
        self.actorOne = [dict objectForKey:@"actorOne"];
        self.actorTwo = [dict objectForKey:@"actorTwo"];
        self.color = [dict objectForKey:@"color"];
    }
    return self;
}

@end