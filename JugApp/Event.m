//
//  Event.m
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import "Event.h"

@implementation Event
@synthesize title;
@synthesize date;
@synthesize description;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    [title dealloc];
    [date dealloc];
    [description dealloc];
    [super dealloc];
}

@end
