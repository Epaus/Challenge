//
//  NSString+NSString_secureURL.h
//  Challenge
//
//  Created by Estelle Paus on 8/28/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NSString_secureURL)

+(NSString *)secureUrl:(NSString*) url;

@end

NS_ASSUME_NONNULL_END
