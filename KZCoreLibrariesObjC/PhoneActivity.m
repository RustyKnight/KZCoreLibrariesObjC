//
//  PhoneActivity.m
//  UIActivityTest
//
//  Created by Shane Whitehead on 10/06/2015.
//  Copyright (c) 2015 Shane Whitehead. All rights reserved.
//

#import "PhoneActivity.h"
#import "ActivitiesUtilities.h"

@implementation PhoneActivity {
	NSString* phoneNumber;
}

-(NSString *)activityType {
	return @"com.apple.phone";
}

-(NSString *)activityTitle {
	return @"Phone";
}

- (UIImage *)_activityImage {
	
	//-(UIImage *)activityImage {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		return nil;
	}
	else
	{
		return [UIImage imageNamed:@"PhoneActivity.png"];
	}
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
	NSLog(@"canPerformWithActivityItems");
	BOOL hasActivity = NO;
	for (id value in activityItems) {
		
		if ([value isKindOfClass:[NSString class]]) {
			
			if ([ActivitiesUtilities isPhoneNumberText:value]) {
				
				phoneNumber = value;
				hasActivity = YES;
				break;
				
			} else if ([ActivitiesUtilities isPhoneNumberURLFromText:value]) {
				
				NSString *text = value;
				NSRange range = [text rangeOfString:@"://"];
				text = [text substringFromIndex:range.location + 3];
				phoneNumber = text;
				hasActivity = YES;
				break;
				
			}
			
		} else if ([value isKindOfClass:[NSURL class]]) {
			
			if ([ActivitiesUtilities isPhoneNumberURL:value]) {
				
				NSURL *url = value;
				NSString *text = [url host];
				phoneNumber = text;
				hasActivity = YES;
				break;
				
			}
			
		}
	}
	
	if (hasActivity) {
		
		hasActivity = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
		NSLog(@"canOpenURL: tel:// = %d with %@", hasActivity, phoneNumber);
		
	}
	return hasActivity;
}

-(UIViewController *)activityViewController {
	return nil;
}

-(void)performActivity {
	NSMutableString *text = [[NSMutableString alloc] initWithString:@"tel://"];
	[text appendString:phoneNumber];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:text]];
	[self activityDidFinish:YES];
}

+(UIActivityCategory)activityCategory {
	return UIActivityCategoryShare;
}

@end
