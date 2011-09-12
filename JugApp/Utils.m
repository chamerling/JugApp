//
//  Utils.m
//  JugApp
//
//  Created by Christophe Hamerling on 03/08/11.
//  Copyright 2011 chamerling.org. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils

static NSString* const kGravatarAPIRoot = @"http://www.gravatar.com/avatar/";
static Utils *singleton;

+ (Utils *) singleton {
    @synchronized (self) {
        if (!singleton) {
            singleton = [[Utils alloc] init];
        }
        return singleton;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString*)MD5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3], 
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];  
}

- (UIImage*)avatarWithEmail:(NSString*)email size:(CGFloat)size defaultImage:(NSString*)def rating:(NSString*)rating error:(NSError**)error
{
    if (!email) { return nil; }
    NSMutableString *requestURL = [NSMutableString stringWithFormat:@"%@%@", kGravatarAPIRoot, [self MD5:email]];
    if (size) { [requestURL appendFormat:@"?s=%d&", (int)size]; } 
    if (def) { [requestURL appendFormat:@"?d=%@&", def]; }
    if (rating) { [requestURL appendFormat:@"?r=%@", rating]; }
    NSLog(@"Gravatar URL to call %@", requestURL);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:requestURL]];
    NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:error];
    [request release];
    return [[[UIImage alloc] initWithData:imageData] autorelease];
}  
@end
