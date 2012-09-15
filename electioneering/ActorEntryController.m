//
//  ActorEntryController.m
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import "ActorEntryController.h"
#import "LocalActors.h"

static const int logoTag = 1000;
static const int labelLeftTag = 1001;
static const int labelRightTag = 1002;

@interface ActorEntryController ()

@property (nonatomic, assign) BOOL actorEnteredLeft;
@property (nonatomic, assign) BOOL actorEnteredRight;

@end

@implementation ActorEntryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyNavBar];
    self.textFieldLeft.delegate = self;
    self.textFieldRight.delegate = self;
    self.textFieldLeft.tag = labelLeftTag;
    self.textFieldRight.tag = labelRightTag;
    self.compareButton.enabled = NO;
}

- (void)modifyNavBar {
    UIImage *logo = [UIImage imageNamed:@"header.png"];
    [[self.navigationController navigationBar] setTintColor:[UIColor colorWithRed:160/255.0f green:29/255.0f blue:31/255.0f alpha:1.0f]];
    //[[self.navigationController navigationBar] setBackgroundImage:logo forBarMetrics:UIBarMetricsDefault];
    [logo release];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *actorEntryLeft = self.textFieldLeft.text;
    NSString *actorEntryRight = self.textFieldRight.text;
    [[LocalActors sharedInstance] setActorOne:actorEntryLeft];
    [[LocalActors sharedInstance] setActorTwo:actorEntryRight];
    
    if ([actorEntryLeft isEqualToString:@""] || [actorEntryRight isEqualToString:@""]) {
        self.compareButton.enabled = NO;
    } else {
        self.compareButton.enabled = YES;
    }
    
    if ([string isEqualToString:@"\n"]) {
        if (textField.tag == labelLeftTag) {
            [self.textFieldLeft resignFirstResponder];
            [self.textFieldRight becomeFirstResponder];
        } else {
            [self.textFieldRight resignFirstResponder];
        }
        return NO;
    }
    else {
        return YES;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown && interfaceOrientation != UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    // custom deallocs
    [super dealloc];
}

@end