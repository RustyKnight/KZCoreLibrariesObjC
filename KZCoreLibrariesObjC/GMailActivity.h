//
//  GMailActivity.h
//  UIActivityTest
//
//  Created by Shane Whitehead on 10/06/2015.
//  Copyright (c) 2015 Shane Whitehead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMailActivity : UIActivity

-(id)initWithCallbackURL:(NSURL*)callbackURL;
-(id)initWithCallbackURL:(NSURL *)callbackURL withSubject:(NSString*)subject;

@property (strong, nonatomic) NSURL *callbackURL;

@end
