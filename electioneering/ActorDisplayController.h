//
//  ActorDisplayController.h
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElectioneeringAPI.h"

@interface ActorDisplayController : UIViewController <UIScrollViewDelegate, DataProtocol>

@property (nonatomic, retain) ElectioneeringAPI *electioneeringAPI;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *actorLabelLeft;
@property (nonatomic, retain) IBOutlet UILabel *actorLabelRight;

@end