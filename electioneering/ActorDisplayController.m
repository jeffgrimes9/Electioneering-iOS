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
    [self.scrollView setFrame:CGRectMake(0, 33, self.view.frame.size.width, self.view.frame.size.height - 33)];
    self.scrollView.contentSize = CGSizeMake(480, 682); // 682 = 12*55 (cell height) + 11*2 (spacing between cells)
    
    NSString *fontName = @"Arial Rounded MT Bold";
    
    self.actorLabelLeft.font = [UIFont fontWithName:fontName size:21];
    self.actorLabelRight.font = [UIFont fontWithName:fontName size:21];
    self.actorLabelLeft.text = [[LocalActors sharedInstance] actorOne];
    self.actorLabelRight.text = [[LocalActors sharedInstance] actorTwo];
    
    [self addData];
}

- (void)addData {
    int numberOfCells = 12;
    int cellSpacing = 2;
    int cellHeight = 55;
    int yVal = 0;
    for (int i = 0; i < numberOfCells; i++) {
        UIImageView *tester = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"abortiongreen.png"]];
        UILabel *label = [[UILabel alloc] init];
        tester.frame = CGRectMake(0, yVal, 480, cellHeight);
        label.text = @"Barack Obama is an alright guy";
        [self.scrollView addSubview:tester];
        [label release];
        [tester release];
        yVal += cellHeight + cellSpacing;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown && interfaceOrientation != UIInterfaceOrientationPortrait);
}

@end