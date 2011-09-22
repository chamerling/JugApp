//
//  JUGAddViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 21/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JUGAddViewController.h"
#import "JUGsMapView.h"
#import "Constants.h"
#import "JSONParser.h"

#import "SVProgressHUD.h"

@implementation JUGAddViewController

@synthesize table;
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [mapButton addTarget:self action:@selector(map:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mapButton];
    
    [super viewDidLoad];
    self.title = @"Available JUGs";
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [SVProgressHUD showInView:self.view];
    
    // By using [self requestWithURL:@"..."]; the reques is cancelled if the user closes this view controller
    ASIHTTPRequest* request = [self requestWithURL:jugRepository];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest*)request {
    [SVProgressHUD dismiss];
    JSONParser *parser = [[JSONParser alloc]init];
    self.jugs = [parser getJugs:[request responseString]];
    [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

- (void)requestFailed:(ASIHTTPRequest*)request {
    [SVProgressHUD dismissWithError:[[request error] localizedDescription]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) imageLoaded:(UIImage*)image withURL:(NSURL*)url {
    [self refreshCellsWithImage:image fromURL:url inTable:table];
}

#pragma mark - actions

-(void) map:(id)sender {
    JUGsMapView *view = [[JUGsMapView alloc] init];
    view.title = @"Map";
    view.jugs = jugs;
    [self.navigationController pushViewController:view animated:YES];
}

- (void)dealloc {
    [table release];
    [jugs release];
    [super dealloc];
}

#pragma mark - table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [jugs count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"TODO : Add it to the list of jugs");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    JugInformation *jug = [jugs objectAtIndex:indexPath.row];
    cell.textLabel.text = jug.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", jug.description];
    return cell;
}


@end
