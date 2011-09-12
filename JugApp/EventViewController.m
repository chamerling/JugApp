//
//  EventViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 12/09/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import "EventViewController.h"
#import "Event.h"

@implementation EventViewController

@synthesize event;// = _event;

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
    
    webView.backgroundColor = [UIColor whiteColor];
    for(UIView *wview in [[[webView subviews] objectAtIndex:0] subviews]) { 
		if([wview isKindOfClass:[UIImageView class]]) { wview.hidden = YES; } 
	}

    if (self.event) {
        [self showEvent:self.event];
    }
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [titleLabel release];
    titleLabel = nil;
    [dateLabel release];
    dateLabel = nil;
    [webView release];
    webView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [titleLabel release];
    [dateLabel release];
    [webView release];
    [super dealloc];
}

- (void)showEvent:(Event *)e {
    self.event = e;
    NSString *htmlString;
	if (self.event.description == nil) {
		htmlString = [NSString stringWithFormat:@"<html><head></head><body><p>%@</p></body></html>", @"<br />"];
    } else {
		htmlString = [NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0 5px 0 0; } p { color:black; font-family:Helvetica; font-size:16px; } a { color:#21759b; text-decoration:none; }</style></head><body><p>%@</p></body></html>", [[self.event description] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"]];
    }
	webView.delegate = self;
	[webView loadHTMLString:htmlString baseURL:nil];
    
    [dateLabel setText:[NSString stringWithFormat:@" %@", [self.event date]]];
    [titleLabel setText:[NSString stringWithFormat:@" %@", [self.event title]]];
}


@end
