//
//  JUGAddViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JUGAddViewController.h"

#import "JUGsMapView.h"

@implementation JUGAddViewController

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
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [mapButton addTarget:self action:@selector(map:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mapButton];
    
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

-(void) map:(id)sender {
    JUGsMapView *view = [[JUGsMapView alloc] init];
    view.title = @"Map";
    // TODO: get all the jugs
    //view.jugs = jugs;
    [self.navigationController pushViewController:view animated:YES];
}

@end
