//
//  ActivitiesUtilities.m
//  UIActivityTest
//
//  Created by Shane Whitehead on 11/06/2015.
//  Copyright (c) 2015 Shane Whitehead. All rights reserved.
//

#import "ActivitiesUtilities.h"

@implementation ActivitiesUtilities

+(BOOL)isEMailURLFromText:(NSString *)value {

	BOOL isEmail = NO;
	if ([value hasPrefix:@"mailto://"]) {
		
		isEmail = YES;
		
	}
	
	return isEmail;
	
}

+(BOOL)isEMailText:(NSString *)value {

	BOOL isEmail = NO;
	
	NSRange searchRange = NSMakeRange(0, [value length]);
	NSString *pattern = @"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
	NSError *error = nil;
	
	NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
	NSArray* matches = [regex matchesInString:value options:0 range:searchRange];
	
	isEmail = matches.count == 1;
	
	return isEmail;
	
}

+(BOOL)isEMailURL:(NSURL *)url {

	BOOL isEmail = NO;
	if ([url.scheme  isEqual: @"mailto"]) {
		
		isEmail = YES;
		
	}

	return isEmail;
	
}

+(BOOL)isPhoneNumberText:(NSString *)text {

	BOOL isPhoneNumer = NO;

	NSRange searchRange = NSMakeRange(0, [text length]);
	NSString *pattern = @"^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}$";
	NSError *error = nil;
	
	NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
	NSArray* matches = [regex matchesInString:text options:0 range:searchRange];
	
	isPhoneNumer = matches.count == 1;
	
	return isPhoneNumer;
	
}

+(BOOL)isPhoneNumberURL:(NSURL *)url {

	BOOL isPhoneNumer = NO;
	if ([url.scheme isEqual: @"tel"]) {
		
		isPhoneNumer = YES;
		
	}
	
	return isPhoneNumer;
	
}

+(BOOL)isPhoneNumberURLFromText:(NSString *)value {

	BOOL isPhoneNumer = NO;
	if ([value hasPrefix:@"tel://"]) {
		
		isPhoneNumer = YES;
		
	}
	
	return isPhoneNumer;
	
}

+(NSString*) encodeQueryByAddingPercentEscapes:(NSString*) input {
//	NSString *encodedValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
//	return encodedValue;
	return [input stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
