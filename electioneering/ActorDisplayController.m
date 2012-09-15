//
//  ActorDisplayController.m
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import "ActorDisplayController.h"
#import "LocalActors.h"

@interface ActorDisplayController ()

@property (nonatomic, assign) int contentHeight;

@end

@implementation ActorDisplayController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setFrame:CGRectMake(0, 33, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(480, 271);
    
    self.actorLabelLeft.text = [[LocalActors sharedInstance] actorOne];
    self.actorLabelRight.text = [[LocalActors sharedInstance] actorTwo];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown && interfaceOrientation != UIInterfaceOrientationPortrait);
}

@end