//
//  KZImageUtilities.h
//  KZCoreLibraries
//
//  Created by Shane Whitehead on 4/10/2014.
//  Copyright (c) 2014 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface KZImageUtilities : NSObject
+(CGFloat)scaleFactorToFit:(CGSize) toFit from:(CGSize)original;
+(CGFloat)scaleFactorToFill:(CGSize)toFill from:(CGSize)original;
+(CGFloat)scaleFactorFrom:(CGFloat)original to:(CGFloat)target;

+(CGRect)frameForScale:(CGFloat)scale from:(CGSize)origin to:(CGSize)target;
+(CGRect)frameForScale:(CGFloat)scale from:(CGSize)origin;
+(CGRect)frameToFill:(CGSize)target from:(CGSize)origin;
+(CGRect)frameToFit:(CGSize)target from:(CGSize)origin;
@end
