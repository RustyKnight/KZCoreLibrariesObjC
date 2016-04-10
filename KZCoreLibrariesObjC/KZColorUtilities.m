//
//  ColorUtilities.m
//  TestArc
//
//  Created by Shane Whitehead on 1/09/2014.
//  Copyright (c) 2014 RMIT. All rights reserved.
//

#import "KZColorUtilities.h"

@implementation KZColorUtilities

+(UIColor*)blend:(UIColor*) color1 to:(UIColor*)color2 by:(double)ratio {
	
	CGFloat r = ratio;
	CGFloat ir = 1.0 - ratio;
	
	const CGFloat* rgb1 = CGColorGetComponents(color1.CGColor);
	const CGFloat* rgb2 = CGColorGetComponents(color2.CGColor);
	
//	NSLog(@"Red   = %f/%f", rgb1[0], rgb2[0]);
//	NSLog(@"Green = %f/%f", rgb1[1], rgb2[1]);
//	NSLog(@"Blue  = %f/%f", rgb1[2], rgb2[2]);
	
	CGFloat red = rgb2[0] * r + rgb1[0] * ir;
	CGFloat green = rgb2[1] * r + rgb1[1] * ir;
	CGFloat blue = rgb2[2] * r + rgb1[2] * ir;
	CGFloat alpha = CGColorGetAlpha(color2.CGColor) * r +
									CGColorGetAlpha(color1.CGColor) * ir;
	
	red = MAX(0.0, MIN(1.0, red));
	green = MAX(0.0, MIN(1.0, green));
	blue = MAX(0.0, MIN(1.0, blue));
	alpha = MAX(0.0, MIN(1.0, alpha));
	
	return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
	
}

+(UIColor*)blend:(UIColor*) color1 to:(UIColor*)color2 {
	return [KZColorUtilities blend:color1
															to:color2
															by:0.5];
}

+(UIColor*)darken:(UIColor*) color by:(double)by {
	
	const CGFloat* rgb = CGColorGetComponents(color.CGColor);
	CGFloat red = MAX(0, rgb[0] - 1.0 * by);
	CGFloat green = MAX(0, rgb[1] - 1.0 * by);
	CGFloat blue = MAX(0, rgb[2] - 1.0 * by);
	CGFloat alpha = CGColorGetAlpha(color.CGColor);
	return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
	
}

+(UIColor*)brighten:(UIColor*) color by:(double)by {
	
	const CGFloat* rgb = CGColorGetComponents(color.CGColor);
	CGFloat red = MAX(0, rgb[0] + 1.0 * by);
	CGFloat green = MAX(0, rgb[1] + 1.0 * by);
	CGFloat blue = MAX(0, rgb[2] + 1.0 * by);
	CGFloat alpha = CGColorGetAlpha(color.CGColor);
	return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
	
}

+(double)distance:(UIColor*) from to:(UIColor*) to {

	const CGFloat* rgb1 = CGColorGetComponents(from.CGColor);
	const CGFloat* rgb2 = CGColorGetComponents(to.CGColor);
	
	double a = rgb2[0] - rgb1[0];
	double b = rgb2[1] - rgb1[1];
	double c = rgb2[2] - rgb1[2];
	
	return sqrt(a * a + b * b + c * c);
}

+(NSArray*) getFractionIndicies:(NSArray*) fractions :(double)progress {
	
	NSMutableArray *range = [[NSMutableArray alloc] init];
	
	NSUInteger startPoint = 0;
	while (startPoint < [fractions count] && [fractions[startPoint] floatValue] <= progress) {
		
		startPoint++;
		
	}
	
	if (startPoint >= [fractions count]) {
		
		startPoint = [fractions count] - 1;
		
	} else if (startPoint == 0) {
		
		startPoint = 1;
		
	}
	
	[range addObject:[NSNumber numberWithLong:startPoint - 1]];
	[range addObject:[NSNumber numberWithLong:startPoint]];
	
	return range;
	
}

/**
 *  Returns a blend of a color based on the supplied fractions and colors and progress
 *
 *  @param fractions A list of fractions between 0-1 representing the points at which the corresponding color values will be there stongest
 *  @param colors    A list of colors. There should be a 1:1 relationship between the fractions and colors
 *  @param progress  The blend point
 *
 *  @return A color which is blend of the colors within the progres range of the fractions...
 */
+(UIColor*)blend:(NSArray*)colors fractions:(NSArray*)fractions progress:(double)progress{
	
	UIColor* color = nil;
	
	if (fractions) {
		
		if (colors) {
			
			if ([fractions count] == [colors count]) {
				
				NSArray* indicies  = [KZColorUtilities getFractionIndicies:fractions :progress];
				int from = [indicies[0] intValue];
				int to = [indicies[1] intValue];
				
				float fromFraction = [fractions[from] floatValue];
				float toFraction = [fractions[to] floatValue];
				
				UIColor* fromColor = colors[from];
				UIColor* toColor = colors[to];
				
				float max = toFraction - fromFraction;
				float value = progress - fromFraction;
				float weight = value / max;
				
				color = [KZColorUtilities blend:fromColor to:toColor by:weight];
				
			}
			
		}
		
	}
	
	return color;
	
}

+(UIColor*)applyAlpha:(double)alpha to:(UIColor*)color {
	
	const CGFloat* rgb = CGColorGetComponents(color.CGColor);
	CGFloat red = MAX(0, rgb[0]);
	CGFloat green = MAX(0, rgb[1]);
	CGFloat blue = MAX(0, rgb[2]);
	return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
	
}

+(UIColor*)invertColor:(UIColor *)color {

	const CGFloat* rgb = CGColorGetComponents(color.CGColor);
	CGFloat red = MAX(0, rgb[0]);
	CGFloat green = MAX(0, rgb[1]);
	CGFloat blue = MAX(0, rgb[2]);
	CGFloat alpha = CGColorGetAlpha(color.CGColor);
	return [[UIColor alloc] initWithRed:1.-red green:1.-green blue:1.-blue alpha:alpha];
	
}

+(NSString*)dumpColor:(UIColor*)color {

	const CGFloat* rgb = CGColorGetComponents(color.CGColor);
	CGFloat red = MAX(0, rgb[0]);
	CGFloat green = MAX(0, rgb[1]);
	CGFloat blue = MAX(0, rgb[2]);
	CGFloat alpha = CGColorGetAlpha(color.CGColor);
	
	NSMutableString *value = [[NSMutableString alloc] init];
	[value appendString:[NSString stringWithFormat:@"R%f,", red]];
	[value appendString:[NSString stringWithFormat:@"G%f,", green]];
	[value appendString:[NSString stringWithFormat:@"B%f,", blue]];
	[value appendString:[NSString stringWithFormat:@"A%f", alpha]];

	return value;

}

+(NSArray*)getColorComponents:(UIColor*)color {

	const CGFloat* rgb = CGColorGetComponents(color.CGColor);
	CGFloat red = MAX(0, rgb[0]);
	CGFloat green = MAX(0, rgb[1]);
	CGFloat blue = MAX(0, rgb[2]);
	CGFloat alpha = CGColorGetAlpha(color.CGColor);
	
	NSMutableArray* colors = [[NSMutableArray alloc] init];
	[colors addObject:@(red)];
	[colors addObject:@(green)];
	[colors addObject:@(blue)];
	[colors addObject:@(alpha)];
	
	return colors;
	
}

+(double)colorDistanceFrom:(UIColor *)from to:(UIColor *)to {
	
	NSArray* fromPart = [KZColorUtilities getColorComponents:from];
	NSArray* toPart = [KZColorUtilities getColorComponents:to];
	
	double a = ((NSNumber*)toPart[0]).doubleValue - ((NSNumber*)fromPart[0]).doubleValue;
	double b = ((NSNumber*)toPart[1]).doubleValue - ((NSNumber*)fromPart[1]).doubleValue;
	double c = ((NSNumber*)toPart[2]).doubleValue - ((NSNumber*)fromPart[2]).doubleValue;
	
	return sqrt(a * a + b * b + c * c);
	
}

+(BOOL)isDarkColor:(UIColor *)color {
	
	double white = [KZColorUtilities colorDistanceFrom:color to:[UIColor whiteColor]];
	double dark = [KZColorUtilities colorDistanceFrom:color to:[UIColor blackColor]];
	
	return dark < white;
	
}

@end
