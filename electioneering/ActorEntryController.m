//
//  ActorEntryController.m
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import "ActorEntryController.h"
#import "LocalData.h"
#import "ActorDisplayController.h"
#import "InfoController.h"

static const int logoTag = 1000;
static const int labelLeftTag = 1001;
static const int labelRightTag = 1002;

@interface ActorEntryController ()

@property (nonatomic, assign) BOOL actorLeftIsValid;
@property (nonatomic, assign) BOOL actorRightIsValid;
@property (nonatomic, retain) NSString *predictedString;

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
    self.electioneeringAPI = [ElectioneeringAPI sharedInstance];
    self.electioneeringAPI.actorDelegate = self;
    [self.electioneeringAPI getAllActors];
}

- (void)gotAllActors {
    for (NSDictionary *dict in self.electioneeringAPI.responseArray) {
        NSString *actorName = [dict objectForKey:@"name"];
        [[[LocalData sharedInstance] allActors] addObject:actorName];
    }
}

- (void)gotAllActorsError {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Server Error" message:@"There was an error when the app tried to call the Electioneering server." delegate:self cancelButtonTitle:@"Back" otherButtonTitles: nil];
    [alertView show];
}

- (void)modifyNavBar {
    UIImage *logo = [UIImage imageNamed:@"header.png"];
    [[self.navigationController navigationBar] setTintColor:[UIColor colorWithRed:160/255.0f green:29/255.0f blue:31/255.0f alpha:1.0f]];
    [logo release];
    
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(displayInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [self.navigationItem setRightBarButtonItem:modalButton animated:YES];
    [modalButton release];

}

- (void)displayInfo {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    InfoController *infoController = (InfoController *)[storyboard instantiateViewControllerWithIdentifier:@"info"];
    [self.navigationController pushViewController:infoController animated:YES];
}

- (NSString *)textField:(DOAutocompleteTextField *)textField completionForPrefix:(NSString *)prefix {
    NSArray *autocompleteArray = [NSArray arrayWithArray:[[LocalData sharedInstance] allActors]];
    
    for (NSString *string in autocompleteArray) {
        if ([string hasPrefix:prefix]) {
            NSString *autocompleteString = [string stringByReplacingCharactersInRange:[prefix rangeOfString:prefix] withString:@""];
            self.predictedString = autocompleteString;
            return autocompleteString;
        }
    }
    
    return @"";
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = @"";
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *actorEntryLeft = self.textFieldLeft.text;
    NSString *actorEntryRight = self.textFieldRight.text;
    [[LocalData sharedInstance] setLocalActorOne:actorEntryLeft];
    [[LocalData sharedInstance] setLocalActorTwo:actorEntryRight];
    
    if (![self.textFieldLeft.text isEqualToString:@""] && ![self.textFieldRight.text isEqualToString:@""]) {
        self.compareButton.enabled = YES;
    }
    
    if ([string isEqualToString:@"\n"]) {
        if ([textField.text isEqualToString:@""]) {
            return NO;
        }
        if (textField.tag == labelLeftTag) {            
            self.textFieldLeft.text = [self.textFieldLeft.text stringByAppendingString:self.predictedString];
            
            NSString *actorEntryLeft = self.textFieldLeft.text;
            [[LocalData sharedInstance] setLocalActorOne:actorEntryLeft];
            
            [self.textFieldLeft resignFirstResponder];
            [self.textFieldRight becomeFirstResponder];
        } else if (self.textFieldRight.text) {
            self.textFieldRight.text = [self.textFieldRight.text stringByAppendingString:self.predictedString];
            
            NSString *actorEntryRight = self.textFieldRight.text;
            [[LocalData sharedInstance] setLocalActorTwo:actorEntryRight];
            
            [self.textFieldRight resignFirstResponder];
        }
        return NO;
    }
    else {
        self.predictedString = @"";
        return YES;
    }
}

- (IBAction)compareButtonPressed {
    if (![[[LocalData sharedInstance] allActors] containsObject:self.textFieldLeft.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Politician Not Found" message:[NSString stringWithFormat:@"%@ was not found in our database.", self.textFieldLeft.text] delegate:self cancelButtonTitle:@"Back" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    if (![[[LocalData sharedInstance] allActors] containsObject:self.textFieldRight.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Politician Not Found" message:[NSString stringWithFormat:@"%@ was not found in our database.", self.textFieldRight.text] delegate:self cancelButtonTitle:@"Back" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    if ([self.textFieldLeft.text isEqualToString:self.textFieldRight.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Duplicate Entries" message:@"Please enter two different names." delegate:self cancelButtonTitle:@"Back" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ActorDisplayController *actorDisplayController = (ActorDisplayController *)[storyboard instantiateViewControllerWithIdentifier:@"displayView"];
    [self.navigationController pushViewController:actorDisplayController animated:YES];
    
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