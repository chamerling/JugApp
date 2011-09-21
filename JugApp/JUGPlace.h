//
//  JUGPlace.h
//  JugApp
//
//  Created by Christophe Hamerling on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import "JugInformation.h"

@interface JUGPlace : Place {
    JugInformation *jug;
    NSInteger tag;
}

@property (nonatomic, retain) JugInformation *jug;
@property (nonatomic) NSInteger tag;

@end
