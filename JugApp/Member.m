//
//  Member.m
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Member.h"

@implementation Member

@synthesize name;
@synthesize twitter;
@synthesize bio;
@synthesize email;
@synthesize web;
@synthesize company;
@synthesize companyURL;
@synthesize role;

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
    [twitter dealloc];
    [bio dealloc];
    [email dealloc];
    [company dealloc];
    [companyURL dealloc];
    [role dealloc];
    [super dealloc];
}

@end
