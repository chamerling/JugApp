//
//  EventDetailsViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventDetailsViewController.h"

@implementation EventDetailsViewController
@synthesize eventTitleLabel;
@synthesize event;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    // setting the button here will create the uitoolbar with them, just hide the bar on viewWillDisappear
    [[self navigationController] setToolbarHidden: NO animated:YES];
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(toolbarAction)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setToolbarItems:[NSArray arrayWithObjects:flexible, actionButton, nil] animated:YES];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[self navigationController] setToolbarHidden: YES animated:YES];    
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad
{
    if (self.event) {
        [self showEvent:self.event];
    }
    
    // 
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setEventTitleLabel:nil];
    [eventDateLabel release];
    eventDateLabel = nil;
    [tagsLbel release];
    tagsLbel = nil;
    [eventDescriptionTextView release];
    eventDescriptionTextView = nil;
    [mainView release];
    mainView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [eventTitleLabel release];
    [eventDateLabel release];
    [tagsLbel release];
    [eventDescriptionTextView release];
    [mainView release];
    [super dealloc];
}

- (void)showEvent:(Event *)e {
    self.event = e;
    [eventDateLabel setText:[NSString stringWithFormat:@" %@", [self.event date]]];
    [eventTitleLabel setText:[NSString stringWithFormat:@" %@", [self.event title]]];
    [eventDescriptionTextView setText:[NSString stringWithFormat:@" %@", [self.event description]]];
    [tagsLbel setText:[NSString stringWithFormat:@""]];
}

# pragma mark - Action sheet related stuff

- (void)toolbarAction {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Actions", @"")
                                                             delegate:self 
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel", @"") 
                                               destructiveButtonTitle:nil 
                                                    otherButtonTitles:@"Add to Calendar", @"Tweet it!", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view];
	[actionSheet release];    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%d", buttonIndex);
    if (buttonIndex == 0) {
        [self addToCalendar];
    } else if (buttonIndex == 1) {
        // Add to calendar button
        [self tweet];
    } else if (buttonIndex == 2) {
    } else {
      // NOP
    }
}


# pragma mark - Toolbar Actions

- (void)addToCalendar {
    NSLog(@"Add to calendar");
    
}

- (void)tweet {
    NSLog(@"Tweet");
}
@end
