//
//  News.m
//  JugApp
//
//  Created by Christophe Hamerling on 02/08/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize title;
@synthesize date;
@synthesize content;

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
    [content dealloc];
    [super dealloc];
}

@end
