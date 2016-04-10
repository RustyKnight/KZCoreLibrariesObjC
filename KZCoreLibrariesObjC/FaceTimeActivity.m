//
//  FaceTime.m
//  UIActivityTest
//
//  Created by Shane Whitehead on 10/06/2015.
//  Copyright (c) 2015 Shane Whitehead. All rights reserved.
//

#import "FaceTimeActivity.h"
#import "ActivitiesUtilities.h"

@implementation FaceTimeActivity {
	NSString* number;
}

-(NSString *)activityType {
	return @"com.apple.FaceTime";
}

-(NSString *)activityTitle {
	return @"FaceTime";
}

- (UIImage *)_activityImage {
	
	//-(UIImage *)activityImage {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		return nil;
	}
	else
	{
		return [UIImage imageNamed:@"FaceTimeActivity.png"];
	}
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
	
	BOOL hasActivity = NO;
	for (id value in activityItems) {
		
		if ([value isKindOfClass:[NSString class]]) {
			
			if ([ActivitiesUtilities isPhoneNumberText:value] ||
					[ActivitiesUtilities isEMailText:value]) {
				
				number = value;
				hasActivity = YES;
				break;
				
			} else if ([ActivitiesUtilities isPhoneNumberURLFromText:value] ||
								 [ActivitiesUtilities isEMailURLFromText:value]) {
				
				NSString *text = value;
				NSRange range = [text rangeOfString:@"://"];
				text = [text substringFromIndex:range.location + 3];
				number = text;
				hasActivity = YES;
				break;
				
			}
			
		} else if ([value isKindOfClass:[NSURL class]]) {
			
			if ([ActivitiesUtilities isPhoneNumberURL:value] ||
					[ActivitiesUtilities isEMailURL:value]) {
				
				NSURL *url = value;
				NSString *text = [url host];
				number = text;
				hasActivity = YES;
				break;
				
			}
			
		}
		
	}
	
	if (hasActivity) {
		
		hasActivity = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"facetime://"]];
		NSLog(@"canOpenURL: facetime:// = %d with %@", hasActivity, number);
		
	}
	
	return hasActivity;
}

-(UIViewController *)activityViewController {
	return nil;
}

-(void)performActivity {
	NSMutableString *text = [[NSMutableString alloc] initWithString:@"facetime://"];
	[text appendString:number];
	[[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:text]];
	[self activityDidFinish:YES];
}

+(UIActivityCategory)activityCategory {
	return UIActivityCategoryShare;
}

@end
