//
//  KZStringUtilities.m
//  TestArc
//
//  Created by Shane Whitehead on 2/09/2014.
//  Copyright (c) 2014 RMIT. All rights reserved.
//

#import "KZStringUtilities.h"

@implementation KZStringUtilities

+(NSString*) zeroPadInt:(long)value forDigits:(int)zeros {
	NSString *format = [NSString stringWithFormat:@"%%0%dd", zeros];
//	return [NSString stringWithFormat:format, value];
	return [NSString stringWithFormat:format, value];
//	return [NSString stringWithFormat:@"%@%lx", fz, value];
}

@end
