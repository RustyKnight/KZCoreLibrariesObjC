//
//  KZImageUtilities.m
//  KZCoreLibraries
//
//  Created by Shane Whitehead on 4/10/2014.
//  Copyright (c) 2014 KaiZen. All rights reserved.
//

#import "KZImageUtilities.h"

@implementation KZImageUtilities

+(CGFloat)scaleFactorToFit:(CGSize) toFit from:(CGSize)original {

	double scaledWidth = [KZImageUtilities scaleFactorFrom:original.width to:toFit.width];
	double scaledHeight = [KZImageUtilities scaleFactorFrom:original.height to:toFit.height];

	return MIN(scaledWidth, scaledHeight);
	
}

+(CGFloat)scaleFactorToFill:(CGSize)toFill from:(CGSize)original {

	double scaledWidth = [KZImageUtilities scaleFactorFrom:original.width to:toFill.width];
	double scaledHeight = [KZImageUtilities scaleFactorFrom:original.height to:toFill.height];
	
	return MAX(scaledWidth, scaledHeight);
	
}

+(CGFloat)scaleFactorFrom:(CGFloat)original to:(CGFloat)target {
	
	return target / original;
	
}

+(CGRect)frameForScale:(CGFloat)scale from:(CGSize)origin to:(CGSize)target {
	
	CGFloat scaleWidth = origin.width * scale;
	CGFloat scaleHeight = origin.width * scale;
	
	CGFloat x = (target.width - scaleWidth) / 2;
	CGFloat y = (target.height - scaleHeight) / 2;
	
	return CGRectMake(x, y, scaleWidth, scaleHeight);
	
}

+(CGRect)frameForScale:(CGFloat)scale from:(CGSize)origin {
	
	CGFloat scaleWidth = origin.width * scale;
	CGFloat scaleHeight = origin.width * scale;
	CGSize target = CGSizeMake(scaleWidth, scaleHeight);
	
	return [KZImageUtilities frameForScale:scale from:origin to:target];
	
}


+(CGRect)frameToFill:(CGSize)target from:(CGSize)origin {
	
	CGFloat scale = [KZImageUtilities scaleFactorToFill:target from:origin];
	return [KZImageUtilities frameForScale:scale from:origin to:target];
	
}

+(CGRect)frameToFit:(CGSize)target from:(CGSize)origin {
	
	CGFloat scale = [KZImageUtilities scaleFactorToFit:target from:origin];
	
	return [KZImageUtilities frameForScale:scale from:origin to:target];
	
}


@end
