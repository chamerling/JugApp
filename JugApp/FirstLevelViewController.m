//
//  FirstLevelViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 21/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstLevelViewController.h"
#import "MembersViewController.h"
#import "EventsViewController.h"
#import "InfoViewController.h"
#import "JugListViewController.h"

@implementation FirstLevelViewController

@synthesize controllers;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [controllers release];
    [super dealloc];
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
    // init local
    self.title = @"JUG App";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    JugListViewController *accountsController = [[JugListViewController alloc] init];
    accountsController.title = @"JUGs";
    [array addObject:accountsController];
    [accountsController release];
    
    self.controllers = array;
	[array release];
    
    // add info button...
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [infoButton release];
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.controllers = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FirstCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // get the controller from the cell
    NSUInteger row = [indexPath row];
    UIViewController *controller =	[controllers objectAtIndex:row];
    cell.textLabel.text = controller.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the controller for the given row
    NSUInteger row = [indexPath row];
    UIViewController *controller = [self.controllers objectAtIndex:row];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Special actions
-(void)info:(id)sender {
    NSLog(@"Information button click : TODO");
    /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
						  @"Hey, do you see the disclosure button?"
													message:@"If you're trying to drill down, touch that instead"
												   delegate:nil
										  cancelButtonTitle:@"Won't happen again"
										  otherButtonTitles:nil];
    [alert show];
    [alert release];
    */
    
    InfoViewController *infoView = [[InfoViewController alloc] init];
    infoView.title = @"About";
    [self.navigationController pushViewController:infoView animated:YES];
}

@end
