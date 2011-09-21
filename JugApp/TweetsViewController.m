//
//  TweetsViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TweetsViewController.h"
#import "SVProgressHUD.h"
#import "JSONKit.h"
#import "DictionaryHelper.h"
#import "AsyncCell.h"
#import "WebViewController.h"

@implementation TweetsViewController

@synthesize table;
@synthesize results;
@synthesize tag;

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

#pragma mark - UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [results count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    AsyncCell *cell = (AsyncCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[AsyncCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSLog(@"Cell %d", [indexPath row]);

    
    NSDictionary* obj = [results objectAtIndex:indexPath.row];
    [cell updateCellInfo:obj];
    return cell;
}

- (void) imageLoaded:(UIImage*)image withURL:(NSURL*)url {
    [self refreshCellsWithImage:image fromURL:url inTable:table];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Latest tweets";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [SVProgressHUD showInView:self.view];
    
    // By using [self requestWithURL:@"..."]; the reques is cancelled if the user closes this view controller
    ASIHTTPRequest* request = [self requestWithURL:[NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@", tag]];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest*)request {
    [SVProgressHUD dismiss];
    NSLog(@"%@", [request responseString]);
    NSDictionary* result = [[request responseString] objectFromJSONString];
    NSArray *keys = result.allKeys;
    NSLog(@"KEYS %@", keys);
    self.results = [result arrayForKey:@"results"];
    [table reloadData];
}

- (void)requestFailed:(ASIHTTPRequest*)request {
    [SVProgressHUD dismissWithError:[[request error] localizedDescription]];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)dealloc {
    [table release];
    [results release];
    
    [super dealloc];
}

- (IBAction)openInBrowser:(id)sender {
    if (tag == nil) return;
    
     NSString *twitter = [NSString stringWithFormat:@"http://m.twitter.com/%@%@", @"@", tag];
     WebViewController *controller = [[WebViewController alloc] init];
     controller.url = twitter;
     controller.title = @"Tweets";
     [self.navigationController pushViewController:controller animated:YES];
     [controller release];

}
@end
