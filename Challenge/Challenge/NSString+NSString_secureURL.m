//
//  NSString+NSString_secureURL.m
//  Challenge
//
//  Created by Estelle Paus on 8/28/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

#import "NSString+NSString_secureURL.h"

@implementation NSString (NSString_secureURL)

+(NSString *)secureUrl:(NSString*) url  {
    NSString * newString = [url stringByReplacingOccurrencesOfString:@"http"
    withString:@"https"];
    return newString;
}

@end
