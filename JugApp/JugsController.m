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
#import "JSONLoader.h"
#import "Constants.h"
#import "InfoViewController.h"

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

- (void) viewDidLoad
{
    self.title = @"JUGApp";
    
    // add info button...
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [infoButton release];
    
    // load the data if not already here...
    if (self.jugs) {
        
    } else {
        // load the data from cache and from URL...
        // for now just from URL...
        [self launchLoadData];
    }
    
    [super viewDidLoad];
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

# pragma mark - load data...
-(void)launchLoadData {
    [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
}

- (void) loadData {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self loadDataFromURL:nil];
    // reload UI in main thread is a good practice...
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [pool release];
}

- (void)loadDataFromURL:(NSString*)url {
    JSONLoader *loader = [[JSONLoader alloc] init];
    self.jugs = [loader getJugsFromURL:jugRepository];
    [loader release];
}

#pragma mark - Special actions
-(void)info:(id)sender {
    InfoViewController *infoView = [[InfoViewController alloc] init];
    infoView.title = @"About";
    [self.navigationController pushViewController:infoView animated:YES];
}

@end
