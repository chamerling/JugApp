//
//  WebViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 03/08/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

@synthesize url;

- (id)init {
    
	if (self = [ super init ]) {
		// If init succeed, do some work
        NSLog(@"Init");
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

- (void)loadView
{
}

- (void)viewDidLoad
{
    webView = [[UIWebView alloc] init];
    webView.delegate = self;
    self.view = webView;
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	spinner.hidesWhenStopped = YES;
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:spinner];
	self.navigationItem.rightBarButtonItem = item;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // load the URL...
    if (self.url) {
        NSURL *urltocall = [NSURL URLWithString:self.url];
        NSURLRequest *request = [NSURLRequest requestWithURL:urltocall];
        NSLog(@"URL to call %@", urltocall);
        [webView loadRequest:request];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // if not done, the app crash...
    if (webView.loading) {
		[webView stopLoading];
	}
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	webView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - web view delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"Start load...");
    [spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"load done...");

    [spinner stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error %@", error.description);
    [spinner stopAnimating];
}

- (void)dealloc {
    webView.delegate = nil;
	[webView release];
	[super dealloc];
}


@end
