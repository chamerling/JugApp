//
//  JUGPlace.m
//  JugApp
//
//  Created by Christophe Hamerling on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JUGPlace.h"

@implementation JUGPlace

@synthesize jug;
@synthesize tag;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc 
{
    [jug release];
    [super dealloc];
}

@end
