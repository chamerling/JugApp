//
//  EventsViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import "EventsViewController.h"
#import "Event.h"
#import "EventDetailViewController.h"


@implementation EventsViewController
@synthesize events;
@synthesize upcoming;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    // load the events from remote source : TODO
 /*   NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:now];
    NSLog(@"%@",dateString);
    
    Event *e1 = [[Event alloc] init];
    e1.title = @"Maven & GWT";
    e1.description = @"This first event will focus on Maven management tool and on Google Web Toolkit...";
    e1.date = dateString;

    Event *e2 = [[Event alloc] init];
    e2.title = @"Android";
    e2.description = @"This second event will focus on the Android platform...";
    e2.date = dateString;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:e1, e2, nil];
    self.events = array;
    
    [array release];
  */
    
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
    NSUInteger row = indexPath.row;
    Event *event = [self.events objectAtIndex:row];
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = event.date;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger selected = indexPath.row;
    Event *event = [events objectAtIndex:selected]; 
    EventDetailViewController *detailViewController = [[EventDetailViewController alloc] init];
    detailViewController.event = event;
    detailViewController.title = event.title;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

- (void)dealloc {
    [events dealloc];
    [super dealloc];
}

@end
