//
//  ColorUtilities.h
//  TestArc
//
//  Created by Shane Whitehead on 1/09/2014.
//  Copyright (c) 2014 RMIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

@interface KZColorUtilities : NSObject
+(UIColor*)blend:(UIColor*) color1 to:(UIColor*)color2 by:(double)ratio;
+(UIColor*)blend:(UIColor*) color1 to:(UIColor*)color2;
+(UIColor*)darken:(UIColor*) color by:(double)by;
+(UIColor*)brighten:(UIColor*) color by:(double)by;

+(double)distance:(UIColor*) from to:(UIColor*) to;

/*
 fractions is a list of NSNumbers, where the float value is used, typically between 0 and 1
 colors is a list of UIColors to be blended
 progress is a value between 0 and 1
 
 There should the same number of entries in both fractions and colors
 */
+(UIColor*)blend:(NSArray*)colors fractions:(NSArray*)fractions progress:(double)progress;
+(UIColor*)applyAlpha:(double)alpha to:(UIColor*)color;

+(UIColor*)invertColor:(UIColor *)color;
+(NSString*)dumpColor:(UIColor*)color;

/**
 * Return the "distance" between two colors. The rgb entries are taken
 * to be coordinates in a 3D space [0.0-1.0], and this method returnes
 * the distance between the coordinates for the first and second color.
 
 *  @param from The color to measure from
 *  @param to   The color to measure to
 *
 *  @return The distance between the two colors as measurement of between 0-1
 */
+(double)colorDistanceFrom:(UIColor*)from to:(UIColor*)to;

/**
 *  Measures the color to determine if it's "dark" or not.  This is determined by
 *  measureing the distance the color is from white and black
 *
 *  @param color The color to be checked
 *
 *  @return True of the color is closer to black then white
 */
+(BOOL)isDarkColor:(UIColor*)color;
@end
