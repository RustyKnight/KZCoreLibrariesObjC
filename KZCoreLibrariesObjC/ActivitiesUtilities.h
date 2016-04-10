//
//  ActivitiesUtilities.h
//  UIActivityTest
//
//  Created by Shane Whitehead on 11/06/2015.
//  Copyright (c) 2015 Shane Whitehead. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivitiesUtilities : NSObject

+(BOOL)isPhoneNumberText:(NSString*) value;
+(BOOL)isEMailText:(NSString*) value;

+(BOOL)isPhoneNumberURLFromText:(NSString*) value;
+(BOOL)isEMailURLFromText:(NSString*) value;


+(BOOL)isPhoneNumberURL:(NSURL*) value;
+(BOOL)isEMailURL:(NSURL*) value;

+(NSString*) encodeQueryByAddingPercentEscapes:(NSString*) input;

@end
