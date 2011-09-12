//
//  JugInformation.m
//  JugApp
//
//  Created by Christophe Hamerling on 26/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import "JugInformation.h"

@implementation JugInformation
@synthesize name;
@synthesize description;
@synthesize city;
@synthesize country;
@synthesize website;
@synthesize twitter;
@synthesize email;
@synthesize apiURL;
@synthesize apiVersion;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    [name dealloc];
    [description dealloc];
    [city dealloc];
    [country dealloc];
    [website dealloc];
    [twitter dealloc];
    [email dealloc];
    [apiURL dealloc];
    [apiVersion dealloc];
    [super dealloc];
}

@end
