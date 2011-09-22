//
//  Event.h
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject {
    NSString *title;
    NSString *date;
    NSString *description;
    NSString *location;
}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *location;

@end
