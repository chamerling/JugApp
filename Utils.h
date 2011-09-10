//
//  Utils.h
//  JugApp
//
//  Created by Christophe Hamerling on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (Utils *) singleton;

- (NSString*)MD5:(NSString *)string;
- (UIImage*)avatarWithEmail:(NSString*)email size:(CGFloat)size defaultImage:(NSString*)def rating:(NSString*)rating error:(NSError**)error;


//-(NSString*) getMD5OfString:(NSString*) hashme;

@end
