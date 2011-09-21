//
//  JUGsMapView.m
//  JugApp
//
//  Display all the registered JUGs in a map and add some control to display details.
//
//  Created by Christophe Hamerling on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JUGsMapView.h"
#import "JUGPlace.h"
#import "JugDetailsViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@implementation JUGsMapView

@synthesize map;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int size = [jugs count];
    
    CLLocationDegrees maxLat = -90.0f;
	CLLocationDegrees maxLon = -180.0f;
	CLLocationDegrees minLat = 90.0f;
	CLLocationDegrees minLon = 180.0f;
    
    
    for (int i = 0; i < size; i++) {
        JugInformation *jugInformation = [jugs objectAtIndex:i];
        
        JUGPlace* a = [[JUGPlace alloc] init];
        a.title = jugInformation.name;
        a.subtitle = [NSString stringWithFormat:@"%@ - %@", jugInformation.city, jugInformation.country];
        a.coordinate = CLLocationCoordinate2DMake([jugInformation.latitude doubleValue], [jugInformation.longitude doubleValue]);
        a.jug = jugInformation;
        a.tag = i;
        
        // TODO : add some action on pin selection
        
        if(a.coordinate.latitude > maxLat) {
			maxLat = a.coordinate.latitude;
		}
		if(a.coordinate.latitude < minLat) {
			minLat = a.coordinate.latitude;
		}
		if(a.coordinate.longitude > maxLon) {
			maxLon = a.coordinate.longitude;
		}
		if(a.coordinate.longitude < minLon) {
			minLon = a.coordinate.longitude;
		}
        
        [map addAnnotation:a];
        [a release];
    }
	
	MKCoordinateRegion region;
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = maxLat - minLat;
	region.span.longitudeDelta = maxLon - minLon;
	
	[map setRegion:region animated:YES];
    
    //MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(a.coordinate, 5000, 5000);
    //MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion];
    
    //[map setRegion:adjustedRegion animated:YES]; 
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
	if ([annotation isKindOfClass:[JUGPlace class]]) {
		MKPinAnnotationView* pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
		pin.canShowCallout = YES;
        pin.pinColor = MKPinAnnotationColorRed;
        pin.animatesDrop = YES;
        
        JUGPlace *place = (JUGPlace *)annotation;
        
        // create the button to show jug details
        UIButton *detailsButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        detailsButton.tag = place.tag;
        //detailsButton.buttonType = UIButtonTypeDetailDisclosure;
        [detailsButton addTarget:self action:@selector(showJUGDetails:) forControlEvents:UIControlEventTouchUpInside];
        pin.rightCalloutAccessoryView = detailsButton;
		return pin;
	}
	return nil;
}

- (void) showJUGDetails:(id)sender 
{
    // get the JUG from the initial map
    UIButton *button = (UIButton*)sender;
    JugInformation *selected = [self.jugs objectAtIndex:button.tag];
    NSLog(@"Selected JUG is %@", selected.name);
    
    JugDetailsViewController *controller = [[JugDetailsViewController alloc] init];
    controller.jug = selected;
    controller.title = selected.name;
    [self.navigationController pushViewController:controller
										 animated:YES];
    [controller release]; 
    
}
@end
