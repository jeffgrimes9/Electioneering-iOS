//
//  ElectioneeringIssue.h
//  electioneering
//
//  Created by Jeff Grimes on 9/15/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ElectioneeringIssue : NSObject

@property (nonatomic, retain) NSString *issueName;
@property (nonatomic, retain) NSString *actorOneStance;
@property (nonatomic, retain) NSString *actorTwoStance;
@property (nonatomic, retain) NSString *color;

- (id)initWithDict:(NSDictionary *)dict;

@end