//
//  ImageCache.h
//  WordPress
//
//  Created by Josh Bassett on 15/07/09.
//

#import <Foundation/Foundation.h>


@interface WPImageCache : NSObject {
@private
    NSMutableDictionary *_data;
}

+ (WPImageCache *)sharedImageCache;

- (void)storeData:(NSData *)data forURL:(NSURL *)url;
- (NSData *)dataForURL:(NSURL *)url;

@end
