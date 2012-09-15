//
//  ActorDisplayController.h
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActorDisplayController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *actorLabelLeft;
@property (nonatomic, retain) IBOutlet UILabel *actorLabelRight;

@end