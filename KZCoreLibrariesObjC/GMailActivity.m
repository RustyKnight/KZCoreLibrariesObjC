//
//  GMailActivity.m
//  UIActivityTest
//
//  Created by Shane Whitehead on 10/06/2015.
//  Copyright (c) 2015 Shane Whitehead. All rights reserved.
//

#import "GMailActivity.h"
#import "ActivitiesUtilities.h"

@implementation GMailActivity {
	NSString *emailAddress;
	NSString *emailBody;
	NSString *emailSubject;
}

-(id)initWithCallbackURL:(NSURL *)callbackURL {
	
	self = [super init];
	if (self) {
		
		self.callbackURL = callbackURL;
		
	}
	
	return self;
	
}

-(id)initWithCallbackURL:(NSURL *)callbackURL withSubject:(NSString *)subject {
	
	self = [self initWithCallbackURL:callbackURL];
	if (self) {
		
		emailSubject = subject;
		
	}
	
	return self;
	
}

-(NSString *)activityType {
	return @"com.google.gmail";
}

-(NSString *)activityTitle {
	return @"GMail";
}

- (UIImage *)_activityImage {
	
	//-(UIImage *)activityImage {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		return nil;
	}
	else
	{
		return [UIImage imageNamed:@"GMailActivity.png"];
	}
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
	
	BOOL hasActivity = NO;
	for (id value in activityItems) {
		
		if ([value isKindOfClass:[NSString class]]) {
			
			NSString* text = value;
			if ([ActivitiesUtilities isEMailText:text]) {
				
				emailAddress = text;
				hasActivity = YES;
				break;
				
			} else if ([ActivitiesUtilities isEMailURLFromText:text]) {
				
				hasActivity = YES;
				break;
				
			} else {
				
				emailBody = text;
				
			}
			
		} else if ([value isKindOfClass:[NSURL class]]) {
			
			NSURL *url = value;
			if ([ActivitiesUtilities isEMailURL:url]) {
				
				NSURL *url = value;
				NSString *text = [url host];
				emailAddress = text;
				hasActivity = YES;
				break;
				
			}
			
		}
		
	}
	
	if (hasActivity || emailBody) {
		
		hasActivity = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlegmail-x-callback://"]];
		NSLog(@"canOpenURL: googlegmail-x-callback:// = %d with %@", hasActivity, emailAddress);
		
	}
	
	return hasActivity;
	
}

-(UIViewController *)activityViewController {
	return nil;
}

-(void)performActivity {
	
	NSMutableString *text = [[NSMutableString alloc] initWithString:@"googlegmail-x-callback://x-callback-url/co?"];
	[text appendFormat:@"to=%@", [ActivitiesUtilities encodeQueryByAddingPercentEscapes: emailAddress]];
	[text appendFormat:@"&subject=%@", [ActivitiesUtilities encodeQueryByAddingPercentEscapes: emailSubject]];
	if (emailBody) {
		[text appendFormat:@"&body=%@", [ActivitiesUtilities encodeQueryByAddingPercentEscapes: emailAddress]];
	}
	[text appendFormat:@"&x-success=%@", [ActivitiesUtilities encodeQueryByAddingPercentEscapes: self.callbackURL.absoluteString]];
	
	NSLog(@"Perform %@", text);
	
	[[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:text]];
	[self activityDidFinish:YES];
	
}

+(UIActivityCategory)activityCategory {
	return UIActivityCategoryShare;
}

@end
