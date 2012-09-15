//
//  ElectioneeringAPI.h
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActorProtocol <NSObject>
- (void)gotData;
- (void)gotDataError;
@end

@interface ElectioneeringAPI : NSObject

@property (nonatomic, assign) id <ActorProtocol> actorDelegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, retain) NSDictionary *responseDict;
@property (nonatomic, retain) NSMutableArray *responseArray;
@property (nonatomic, assign) SEL successSelector;
@property (nonatomic, assign) SEL failureSelector;

- (void)getDataForActorOne:(NSString *)actorOneId actorTwo:(NSString *)actorTwoId;

@end