//
//  NewViewController.m
//  JugApp
//
//  Created by Christophe Hamerling on 05/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation NewViewController

@synthesize news = _news;

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
    //imageNews.layer cornerRadius = 10.0f;
    //imageNews.layer masksToBounds = YES;
    imageNews.image = [UIImage imageNamed:@"avatar.jpg"]; 
    imageNews.layer.masksToBounds = YES;
    imageNews.layer.cornerRadius = 10.0;
    imageNews.layer.borderWidth = 1.0;
    imageNews.layer.borderColor = [[UIColor grayColor] CGColor];
    
    newsBody.backgroundColor = [UIColor whiteColor];
	//hide the shadow for the UIWebView, nicked from stackoverflow.com/questions/1074320/remove-uiwebview-shadow/
	for(UIView *wview in [[[newsBody subviews] objectAtIndex:0] subviews]) { 
		if([wview isKindOfClass:[UIImageView class]]) { wview.hidden = YES; } 
	}
    
    newsBody.layer.masksToBounds = YES;
    newsBody.layer.cornerRadius = 10.0;
    newsBody.layer.borderWidth = 1.0;
    newsBody.layer.borderColor = [[UIColor grayColor] CGColor];

    if (self.news) {
        [self showNews:self.news];
    }

}

- (void)showNews:(News *)news {
    self.news = news;
    NSString *htmlString;
	if (news.content == nil) {
		htmlString = [NSString stringWithFormat:@"<html><head></head><body><p>%@</p></body></html>", @"<br />"];
    } else {
		htmlString = [NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0 5px 0 0; } p { color:black; font-family:Helvetica; font-size:16px; } a { color:#21759b; text-decoration:none; }</style></head><body><p>%@</p></body></html>", [[self.news content] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"]];
    }
	newsBody.delegate = self;
	[newsBody loadHTMLString:htmlString baseURL:nil];
    
    [publishedLabel setText:[NSString stringWithFormat:@" %@", [news date]]];
}

- (void)viewDidUnload
{
    [actionButton release];
    actionButton = nil;
    [newsBody release];
    newsBody = nil;
    [publishedLabel release];
    publishedLabel = nil;
    [imageNews release];
    imageNews = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [actionButton release];
    [newsBody release];
    [publishedLabel release];
    [imageNews release];
    [super dealloc];
}
@end
