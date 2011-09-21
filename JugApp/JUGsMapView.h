//
//  JUGsMapView.h
//  JugApp
//
//  Created by Christophe Hamerling on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "BaseViewController.h"
#import "JugInformation.h"

@interface JUGsMapView : BaseViewController {
    MKMapView *map;
    NSArray *jugs;
}
@property (nonatomic, retain) IBOutlet MKMapView *map;
@property (nonatomic, retain) NSArray *jugs;

-(void)showJUGDetails:(id)sender;

@end
