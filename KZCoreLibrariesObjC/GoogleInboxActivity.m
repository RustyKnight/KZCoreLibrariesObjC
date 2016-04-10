//
//  GoogleInboxActivity.m
//  UIActivityTest
//
//  Created by Shane Whitehead on 9/06/2015.
//  Copyright (c) 2015 Shane Whitehead. All rights reserved.
//

#import "GoogleInboxActivity.h"
#import "ActivitiesUtilities.h"

@implementation GoogleInboxActivity {
	NSString* emailAddress;
	NSString* emailBody;
}

-(NSString *)activityType {
	return @"com.google.inbox";
}

-(NSString *)activityTitle {
	return @"Inbox";
}

- (UIImage *)_activityImage {
	
	//-(UIImage *)activityImage {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		return nil;
	}
	else
	{
		return [UIImage imageNamed:@"GoogleInBoxActivity.png"];
	}
}

-(UIViewController *)activityViewController {
	return nil;
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
				
				hasActivity = YES;
				break;
				
			}
			
		}
		
	}
	
	if (hasActivity || emailBody) {
		
		hasActivity = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"inbox-gmail-x-callback://"]];
		NSLog(@"canOpenURL: inbox-gmail-x-callback:// = %d with %@", hasActivity, emailAddress);
		
	}
	
	return hasActivity;
	
}


-(void)performActivity {
	
	//	NSMutableString *text = [[NSMutableString alloc] initWithString:@"inbox-gmail-x-callback://x-callback-url/co?"];
	NSMutableString *text = [[NSMutableString alloc] initWithString:@"inbox-gmail://co?"];
	[text appendFormat:@"to=%@", [ActivitiesUtilities encodeQueryByAddingPercentEscapes:emailAddress]];
	if (emailBody) {
		
		[text appendFormat:@"body=%@", [ActivitiesUtilities encodeQueryByAddingPercentEscapes:emailBody]];
		
	}
	
	NSLog(@"Perform %@", text);
	
	[[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:text]];
	[self activityDidFinish:YES];
}

+(UIActivityCategory)activityCategory {
	return UIActivityCategoryShare;
}

@end
