//
//  ActorEntryController.h
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOAutocompleteTextField/DOAutocompleteTextField.h"

@interface ActorEntryController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIButton *compareButton;
@property (nonatomic, retain) IBOutlet DOAutocompleteTextField *textFieldLeft;
@property (nonatomic, retain) IBOutlet DOAutocompleteTextField  *textFieldRight;
@property (nonatomic, retain) NSString *actorNameLeft;
@property (nonatomic, retain) NSString *actorNameRight;

- (IBAction)compareButtonPressed;

@end