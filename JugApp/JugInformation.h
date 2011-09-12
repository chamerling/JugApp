//
//  JugInformation.h
//  JugApp
//
//  Created by Christophe Hamerling on 26/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JugInformation : NSObject {
    NSString *name;
    NSString *description;
    NSString *city;
    NSString *country;
    NSString *website;
    NSString *twitter;
    NSString *email;
    NSString *apiURL;
    NSString *apiVersion;
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *twitter;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *apiURL;
@property (nonatomic, retain) NSString *apiVersion;
@end
