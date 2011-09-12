//
//  Member.h
//  JugApp
//
//  Created by Christophe Hamerling on 25/07/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject {
    NSString *name;
    NSString *twitter;
    NSString *bio;
    NSString *email;
    NSString *web;
    NSString *company;
    NSString *companyURL;
    NSString *role;
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *twitter;
@property (nonatomic, retain) NSString *bio;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *web;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *companyURL;
@property (nonatomic, retain) NSString *role;

@end