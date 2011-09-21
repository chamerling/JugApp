//
//  NewsDetaiksViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsDetaiksViewController.h"

@implementation NewsDetaiksViewController
@synthesize newTitle;
@synthesize news;

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
    if (self.news) {
        [self showNews:self.news];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setNewTitle:nil];
    [newsDate release];
    newsDate = nil;
    [newsTags release];
    newsTags = nil;
    [newsDetails release];
    newsDetails = nil;
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
    [newTitle release];
    [newsDate release];
    [newsTags release];
    [newsDetails release];
    [super dealloc];
}

- (void)showNews:(News*)n {
    self.news = n;
    [newsDate setText:[NSString stringWithFormat:@" %@", [self.news date]]];
    [newTitle setText:[NSString stringWithFormat:@" %@", [self.news title]]];
    [newsDetails setText:[NSString stringWithFormat:@" %@", [self.news content]]];
    [newsTags setText:[NSString stringWithFormat:@""]];
}

# pragma mark - Action sheet related stuff

- (void)toolbarAction {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Actions", @"")
                                                             delegate:self 
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel", @"") 
                                               destructiveButtonTitle:nil 
                                                    otherButtonTitles:@"Tweet it!", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view];
	[actionSheet release];    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%d", buttonIndex);
    if (buttonIndex == 0) {
        [self tweet];
    } else {
        // NOP
    }
}

#pragma mark - toolbar actions
- (void) tweet {
    NSLog(@"Tweet it!");
}

@end
