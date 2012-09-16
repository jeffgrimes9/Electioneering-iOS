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
        self.actorOneStance = [dict objectForKey:@"whiteStance"];
        self.actorTwoStance = [dict objectForKey:@"blackStance"];
        self.color = [dict objectForKey:@"color"];
    }
    return self;
}

@end