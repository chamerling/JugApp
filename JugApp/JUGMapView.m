//
//  JUGMapView.m
//  JugApp
//
//  Created by Christophe Hamerling on 16/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JUGMapView.h"
#import "StringHelper.h"
#import "Place.h"

@implementation JUGMapView
@synthesize map;
@synthesize location;
@synthesize jugInformation;

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Place* a = [[Place alloc] init];
    a.title = jugInformation.name;
    a.subtitle = [NSString stringWithFormat:@"%@ - %@", jugInformation.city, jugInformation.country];
    a.coordinate = CLLocationCoordinate2DMake([jugInformation.latitude doubleValue], [jugInformation.longitude doubleValue]);
    
    self.location = a;
    
    [map addAnnotation:a];
    [a release];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(a.coordinate, 5000, 5000);
    MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion];
    
    [map setRegion:adjustedRegion animated:YES];  
    
    
//    [self calculateDirections];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [map release];
    [super dealloc];
}

#pragma mark -

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[Place class]]) {
		MKPinAnnotationView* pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
		pin.canShowCallout = YES;
        pin.pinColor = MKPinAnnotationColorRed;
        pin.animatesDrop = YES;
		return pin;
	}
	return nil;
}


@end
