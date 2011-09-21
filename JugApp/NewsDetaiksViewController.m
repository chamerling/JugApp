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
@end
