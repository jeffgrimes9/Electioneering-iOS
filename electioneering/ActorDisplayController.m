//
//  ActorDisplayController.m
//  electioneering
//
//  Created by Jeff Grimes on 9/14/12.
//  Copyright (c) 2012 Jeff Grimes. All rights reserved.
//

#import "ActorDisplayController.h"
#import "LocalData.h"

@interface ActorDisplayController ()

@property (nonatomic, retain) NSMutableArray *cells;
@property (nonatomic, retain) NSMutableArray *cellLabels;
@property (nonatomic, retain) NSMutableArray *cellDividers;
@property (nonatomic, retain) NSMutableArray *cellLeftDetails;
@property (nonatomic, retain) NSMutableArray *cellRightDetails;

@end

static const int cellHeight = 55;
static const int cellSpacing = 2;
static const int numberOfCells = 14;

@implementation ActorDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cells = [[NSMutableArray alloc] init];
    self.cellLabels = [[NSMutableArray alloc] initWithObjects:[[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], [[UILabel alloc] init], nil];
    self.cellDividers = [[NSMutableArray alloc] initWithObjects:[[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], [[UIView alloc] init], nil];
    self.cellLeftDetails = [[NSMutableArray alloc] initWithObjects:[[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], nil];
    self.cellRightDetails = [[NSMutableArray alloc] initWithObjects:[[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], [[NSString alloc] init], nil];
    
    UITapGestureRecognizer *tapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)] autorelease];
    [self.scrollView addGestureRecognizer:tapRecognizer];
    
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setFrame:CGRectMake(0, 34, self.view.frame.size.width, self.view.frame.size.height - 34)];
    self.scrollView.contentSize = CGSizeMake(480, 796); // 796 = 14*55 (cell height) + 13*2 (spacing between cells)
    
    NSString *fontName = @"Franchise-Bold";
    int fontSize = 32;
    
    self.actorLabelLeft.font = [UIFont fontWithName:fontName size:fontSize];
    self.actorLabelRight.font = [UIFont fontWithName:fontName size:fontSize];
    self.actorLabelLeft.text = [[LocalData sharedInstance] localActorOne];
    self.actorLabelRight.text = [[LocalData sharedInstance] localActorTwo];
    
    [self addData];
    for (int i = 0; i < numberOfCells; i++) {
        [self addTitleLabel:i firstTime:YES];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    CGPoint tapPoint = [sender locationInView:self.scrollView];
    int tapY = tapPoint.y;
    int tapIndex;
    for (int i = 0; i < numberOfCells; i++) {
        int yTop = i * (cellHeight + cellSpacing);
        int yBottom = yTop + cellHeight + cellSpacing;
        if (tapY >= yTop && tapY <= yBottom) {
            tapIndex = i;
        }
    }
    
    NSString *selectionState = [[[LocalData sharedInstance] selectionStates] objectAtIndex:tapIndex];
    if ([selectionState isEqualToString:@"title"]) {
        [[self.cellLabels objectAtIndex:tapIndex] removeFromSuperview];
        UILabel *issueDetailsLeft = [[UILabel alloc] init];
        UILabel *issueDetailsRight = [[UILabel alloc] init];
        issueDetailsLeft.text = @"Candidate 1's stance";
        issueDetailsLeft.font = [UIFont fontWithName:@"Georgia" size:15];
        issueDetailsLeft.backgroundColor = [UIColor clearColor];
        issueDetailsLeft.textColor = [UIColor whiteColor];
        issueDetailsLeft.textAlignment = UITextAlignmentCenter;
        issueDetailsLeft.numberOfLines = 3;
        issueDetailsLeft.adjustsFontSizeToFitWidth = YES;
        issueDetailsRight.text = @"Candidate 2's stance";
        issueDetailsRight.font = [UIFont fontWithName:@"Georgia" size:15];
        issueDetailsRight.backgroundColor = [UIColor clearColor];
        issueDetailsRight.textColor = [UIColor whiteColor];
        issueDetailsRight.textAlignment = UITextAlignmentCenter;
        issueDetailsRight.numberOfLines = 2;
        issueDetailsLeft.adjustsFontSizeToFitWidth = YES;
        CGRect cellFrame = [[self.cells objectAtIndex:tapIndex] frame];
        int labelY = cellFrame.origin.y;
        issueDetailsLeft.frame = CGRectMake(5, labelY+2, 230, cellHeight);
        issueDetailsRight.frame = CGRectMake(245, labelY+2, 230, cellHeight);
        
        UIImageView *whiteLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteLine.png"]];
        whiteLine.frame = CGRectMake(238, cellFrame.origin.y, 4, cellHeight);
        
        [self.cellDividers removeObjectAtIndex:tapIndex];
        [self.cellDividers insertObject:whiteLine atIndex:tapIndex];
        [self.cellLeftDetails removeObjectAtIndex:tapIndex];
        [self.cellRightDetails removeObjectAtIndex:tapIndex];
        [self.cellLeftDetails insertObject:issueDetailsLeft atIndex:tapIndex];
        [self.cellRightDetails insertObject:issueDetailsRight atIndex:tapIndex];
        
        [self.scrollView addSubview:whiteLine];
        [self.scrollView addSubview:issueDetailsLeft];
        [self.scrollView addSubview:issueDetailsRight];
    } else {
        [self addTitleLabel:tapIndex firstTime:NO];
    }
    [[LocalData sharedInstance] changeSelectionStateAtIndex:tapIndex];
}

- (void)addTitleLabel:(int)index firstTime:(BOOL)firstTime {
    if (!firstTime) {
        [[self.cellLabels objectAtIndex:index] removeFromSuperview];
        [[self.cellDividers objectAtIndex:index] removeFromSuperview];
        [[self.cellLeftDetails objectAtIndex:index] removeFromSuperview];
        [[self.cellRightDetails objectAtIndex:index] removeFromSuperview];
    }
    UILabel *issueLabel = [[UILabel alloc] init];
    issueLabel.text = @"ISSUE TITLE";
    issueLabel.font = [UIFont fontWithName:@"Franchise-Bold" size:42];
    issueLabel.backgroundColor = [UIColor clearColor];
    issueLabel.textColor = [UIColor whiteColor];
    issueLabel.textAlignment = UITextAlignmentCenter;
    CGRect cellFrame = [[self.cells objectAtIndex:index] frame];
    int labelY = cellFrame.origin.y;
    issueLabel.frame = CGRectMake(0, labelY+2, 480, cellHeight);
    [self.scrollView addSubview:issueLabel];
    [self.cellLabels removeObjectAtIndex:index];
    [self.cellLabels insertObject:issueLabel atIndex:index];
}

- (void)addData {
    int yVal = 0;
    for (int i = 0; i < numberOfCells; i++) {
        UIImageView *tester = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barBlue"]];
        tester.frame = CGRectMake(0, yVal, 480, cellHeight);
        [self.cells addObject:tester];
        [self.scrollView addSubview:tester];
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