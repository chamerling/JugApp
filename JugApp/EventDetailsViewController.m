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

- (void)viewDidLoad
{
    if (self.event) {
        [self showEvent:self.event];
    }
    
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
    [super dealloc];
}

- (void)showEvent:(Event *)e {
    self.event = e;
    [eventDateLabel setText:[NSString stringWithFormat:@" %@", [self.event date]]];
    [eventTitleLabel setText:[NSString stringWithFormat:@" %@", [self.event title]]];
    [eventDescriptionTextView setText:[NSString stringWithFormat:@" %@", [self.event description]]];
}
@end
