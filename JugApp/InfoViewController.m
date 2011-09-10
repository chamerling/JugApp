//
//  InfoViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"
#import "WebViewController.h"
#import "Constants.h"

@implementation InfoViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)openProjectWebPage:(id)sender {
    WebViewController *controller = [[WebViewController alloc] init];
    controller.url = projectWebPage;
    controller.title = @"Project WebPage";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (IBAction)openJUGPage:(id)sender {
    WebViewController *controller = [[WebViewController alloc] init];
    controller.url = jugPage;
    controller.title = @"JUG Montpellier";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
@end
