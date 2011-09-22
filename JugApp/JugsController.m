//
//  JugsController.m
//  JugApp
//
//  Created by Christophe Hamerling on 13/09/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import "JugsController.h"
#import "JugInformation.h"
#import "JugDetailsViewController.h"
#import "Constants.h"
#import "JUGsMapView.h"
#import "SettingsViewController.h"
#import "JUGAddViewController.h"
#import "JSONParser.h"
#import "Constants.h"

#import "SVProgressHUD.h"

@implementation JugsController

@synthesize jugs;

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

# pragma mark - View lifecycle

- (void) viewDidLoad
{
    self.title = @"JUGApp";
    
    // add button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    //[addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction)];
    self.navigationItem.leftBarButtonItem = editButton;
    [editButton release];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    // setting the button here will create the uitoolbar with them, just hide the bar on viewWillDisappear
    [[self navigationController] setToolbarHidden: NO animated:YES];
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(settingsAction)];
    [self setToolbarItems:[NSArray arrayWithObjects:set, nil] animated:YES];
    [super viewDidAppear:animated];
    
    if (self.jugs) {
        
    } else {
    
        [SVProgressHUD showInView:self.view];
    
        // By using [self requestWithURL:@"..."]; the reques is cancelled if the user closes this view controller
        // FIXME : Use BaseViewController to manager http rquests...
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:jugRepository]];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(requestFinished:)];
        [request setDidFailSelector:@selector(requestFailed:)];
        [request startAsynchronous];
    }
}

- (void)requestFinished:(ASIHTTPRequest*)request {
    [SVProgressHUD dismiss];
    JSONParser *parser = [[JSONParser alloc]init];
    self.jugs = [parser getJugs:[request responseString]];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

- (void)requestFailed:(ASIHTTPRequest*)request {
    [SVProgressHUD dismissWithError:[[request error] localizedDescription]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self navigationController] setToolbarHidden: YES animated:YES];    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.jugs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSUInteger integer = [indexPath row];
    JugInformation *jug = [self.jugs objectAtIndex:integer];
    cell.textLabel.text = jug.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", jug.description];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    JugInformation *selected = [self.jugs objectAtIndex:row]; 
    JugDetailsViewController *detailsController = [[JugDetailsViewController alloc] init];
    detailsController.jug = selected;
    detailsController.title = selected.name;
    [self.navigationController pushViewController:detailsController
										 animated:YES];
    [detailsController release];    
}

#pragma mark - Memory

- (void)dealloc {
    [jugs release];
    [super dealloc];
}

#pragma mark - Special actions

-(void)settingsAction {
    SettingsViewController *controller = [[SettingsViewController alloc] init];
    controller.title = @"Settings";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)addAction {
    JUGAddViewController *controller = [[JUGAddViewController alloc] init];
    controller.title = @"Add JUGs";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

# pragma mark - toolbar actions
- (void)editAction {
    // NOP
    NSLog(@"TODO");
}

@end
