//
//  LocalActors.h
//  electioneering
//
//  Created by Jeff Grimes on 9/15/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalActors : NSObject

@property (nonatomic, retain) NSString *actorOne;
@property (nonatomic, retain) NSString *actorTwo;

+ (id)sharedInstance;

@end