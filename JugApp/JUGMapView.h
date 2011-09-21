//
//  JUGMapView.h
//  JugApp
//
//  Created by Christophe Hamerling on 16/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BaseViewController.h"
#import "JugInformation.h"

@interface JUGMapView : BaseViewController {
    JugInformation *jugInformation;    
}

@property (nonatomic, retain) JugInformation *jugInformation;

@property(nonatomic, retain) id<MKAnnotation> location;
@property (nonatomic, retain) IBOutlet MKMapView *map;

@end
