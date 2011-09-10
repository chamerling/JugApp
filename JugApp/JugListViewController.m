//
//  AccountsViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 26/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JugListViewController.h"
#import "JugInformation.h"
#import "JugDetailsViewController.h"
#import "JSONLoader.h"
#import "Constants.h"
#import "ProgressView.h"

@implementation JugListViewController

@synthesize accounts;
//@synthesize activity;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void) viewDidLoad
{
    dataLoaded = NO;

    [self initSpinner];
    [self launchLoadData];
    
    // refresh button
    refreshButton = [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
    target:self
    action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataLoaded) return [self.accounts count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSUInteger integer = [indexPath row];
    JugInformation *jug = [self.accounts objectAtIndex:integer];
    cell.textLabel.text = jug.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", jug.description];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    JugInformation *selected = [self.accounts objectAtIndex:row]; 
    JugDetailsViewController *detailsController = [[JugDetailsViewController alloc] init];
    detailsController.jug = selected;
    detailsController.title = selected.name;
    [self.navigationController pushViewController:detailsController
										 animated:YES];
    [detailsController release];    
}

# pragma mark - Business and implementation methods

- (void)refresh:(id)sender {
    // remove the data to display emty table...
    self.accounts = nil;
    self.accounts = [[NSMutableArray alloc] init];
    [self.tableView reloadData];

    [self launchLoadData];
}

-(void)launchLoadData {
    NSLog(@"Launching thread");
    [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
}

- (void) loadData {
    dataLoaded = NO;
    NSLog(@" thread launched");
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self loadDataFromURL:nil];
    dataLoaded = YES;
    // reload UI in main thread is a good practice...
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [pool release];
}

- (void)loadDataFromURL:(NSString*)url {
    // start the spinner to show that loading may be time consuming...
    [NSThread detachNewThreadSelector: @selector(spinBegin) toTarget:self withObject:nil];
    JSONLoader *loader = [[JSONLoader alloc] init];
    self.accounts = [loader getJugsFromURL:jugRepository];
    [loader release];
    [NSThread sleepForTimeInterval:1];
    [NSThread detachNewThreadSelector: @selector(spinEnd) toTarget:self withObject:nil];
}

#pragma mark - spinner
- (void)spinBegin {
    NSLog(@"SPIN Begin");
    progressAlert = [[ProgressView alloc] initWithLabel:NSLocalizedString(@"Loading...", @"")];
    [progressAlert show];

    //[activity startAnimating];
}

- (void)spinEnd {
    NSLog(@"SPIN End");
    //[activity stopAnimating];
    [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
    [progressAlert release];
}

- (void) initSpinner {
    // old big center button
    /*activity = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];    
    CGPoint newCenter = (CGPoint) [self.view center];
    activity.center = newCenter;
    [self.view addSubview:activity];
     */
    progressAlert = [[ProgressView alloc] initWithLabel:NSLocalizedString(@"Deleting...", @"")];

}

#pragma mark - Memory

- (void)dealloc {
    [accounts release];
    //[activity release];
    [super dealloc];
}

@end
