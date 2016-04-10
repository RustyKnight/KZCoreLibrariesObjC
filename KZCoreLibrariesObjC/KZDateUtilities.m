//
//  KZDateLibrary.m
//  TestClassSheet
//
//  Created by Shane Whitehead on 1/10/2014.
//  Copyright (c) 2014 KaiZen. All rights reserved.
//

#import "KZDateUtilities.h"

@implementation KZDateUtilities

+(NSString*)dateToString:(NSDate*) date {
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd/MM/yyyy"];
	return [formatter stringFromDate:date];
	
}

+(NSString*)dateTimeToString:(NSDate*) date {
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
	return [formatter stringFromDate:date];
	
}

+(NSDate *)subtractMonthsFrom:(NSDate*)date by:(NSInteger)amount {

	return [KZDateUtilities addMonthsFrom:date by:(amount *= -1)];
	
}

+(NSDate *)addMonthsFrom:(NSDate*)date by:(NSInteger)amount {
	
	NSCalendar* cal = [NSCalendar currentCalendar];
	NSDateComponents* dateComponents = [cal components:(NSCalendarUnitMonth) fromDate:date];
	[dateComponents setMonth:amount];
	
	return [cal dateByAddingComponents:dateComponents toDate:date options:0];
	
}

+(NSDate *)subtractDaysFrom:(NSDate*)date by:(NSInteger)amount {
	
	return [KZDateUtilities addDaysTo:date by:(amount *= -1)];
	
}

+(NSDate *)addDaysTo:(NSDate*)date by:(NSInteger)amount {
	
	NSCalendar* cal = [NSCalendar currentCalendar];
	NSDateComponents* dateComponents = [cal components:(NSCalendarUnitDay) fromDate:date];
	[dateComponents setDay:amount];
	
	return [cal dateByAddingComponents:dateComponents toDate:date options:0];
	
}

+(NSDate *)timeToEndOfDay:(NSDate*)date {

//	NSLog(@"timeToBeforeMidnight before: %@", [KZDateUtilities dateToString:date]);
	
	NSCalendar* cal = [NSCalendar currentCalendar];
	unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitTimeZone;
	NSDateComponents *dateComponents = [cal components:unitFlags fromDate:date];
	[dateComponents setHour:23];
	[dateComponents setMinute:59];
	[dateComponents setSecond:59];
	[dateComponents setNanosecond:0];

	date = [cal dateFromComponents:dateComponents];
	
//	NSLog(@"timeToBeforeMidnight after: %@", [KZDateUtilities dateToString:date]);
	
	return date;
	
}

+(NSDate *)timeToStartOfDay:(NSDate*)date {
	
//	NSLog(@"timeToAfterMidnight before: %@", [KZDateUtilities dateToString:date]);
	
	NSCalendar* cal = [NSCalendar currentCalendar];
	unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitTimeZone;
	NSDateComponents *dateComponents = [cal components:unitFlags fromDate:date];

//	NSLog(@"timeToAfterMidnight dateComponents: %@", dateComponents);
	
	[dateComponents setHour:0];
	[dateComponents setMinute:0];
	[dateComponents setSecond:0];
	[dateComponents setNanosecond:1];

//	NSLog(@"timeToAfterMidnight dateComponents: %@", dateComponents);

	date = [cal dateFromComponents:dateComponents];

//	NSLog(@"timeToAfterMidnight after: %@", [KZDateUtilities dateToString:date]);
	
	return date;
	
}

+(BOOL)isDate:(NSDate*)date before:(NSDate*)before {
	
	BOOL isBefore = NO;
	NSComparisonResult result = [date compare:before];
	if (result == NSOrderedAscending) {
		isBefore = YES;
//		NSLog(@"date < before; %@ < %@", [KZDateUtilities dateToString:date], [KZDateUtilities dateToString:before]);
	} else if (result == NSOrderedSame) {
//		NSLog(@"date == before; %@ == %@", [KZDateUtilities dateToString:date], [KZDateUtilities dateToString:before]);
	} else if (result == NSOrderedDescending) {
//		NSLog(@"date > before; %@ > %@", [KZDateUtilities dateToString:date], [KZDateUtilities dateToString:before]);
	}
	
	return isBefore;
	
}

+(BOOL)isDate:(NSDate*)date after:(NSDate*)after {
	
	BOOL isAfter = NO;
	
	NSComparisonResult result = [date compare:after];
	if (result == NSOrderedAscending) {
//		NSLog(@"date < after; %@ < %@", [KZDateUtilities dateToString:date], [KZDateUtilities dateToString:after]);
	} else if (result == NSOrderedSame) {
//		NSLog(@"date == after; %@ == %@", [KZDateUtilities dateToString:date], [KZDateUtilities dateToString:after]);
	} else if (result == NSOrderedDescending) {
		isAfter = YES;
//		NSLog(@"date > after; %@ > %@", [KZDateUtilities dateToString:date], [KZDateUtilities dateToString:after]);
	}
	
	return isAfter;
	
}

+(NSDate*)createDateWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day {
	return [KZDateUtilities createDateWithYear:year withMonth:month withDay:day beforeMidnight:NO];
}

+(NSDate*)createDateWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day beforeMidnight:(BOOL)beforeMidnight {

	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setYear:year];
	[components setMonth:month];
	[components setDay:day];

	NSDate* date = [calendar dateFromComponents:components];
	
	if (beforeMidnight) {
		
		date = [KZDateUtilities timeToEndOfDay:date];
		
	} else {

		date = [KZDateUtilities timeToStartOfDay:date];
		
	}
	
	return date;
	
}

+(BOOL)dateExcludingTime:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
	
	BOOL between = NO;
	
	beginDate = [KZDateUtilities timeToStartOfDay:beginDate];
	endDate = [KZDateUtilities timeToEndOfDay:endDate];

	if ([KZDateUtilities isDate:date after:beginDate] &&
			[KZDateUtilities isDate:date before:endDate]) {
		
		between = YES;
		
	}
	
//	NSLog(@"dateExcludingTime %@ is bewteen %@ and %@ = %@", [KZDateUtilities dateToString:date],
//				[KZDateUtilities dateToString:beginDate],
//				[KZDateUtilities dateToString:endDate],
//				between ? @"yes" : @"no");
	
	return between;
	
}

+(BOOL)dateExcludingTime:(NSDate*)date isEqualToOrAfterDate:(NSDate*)beginDate andEqualToOrBeforeDate:(NSDate*)endDate {

//	NSLog(@"dateExcludingTime %@ is equal to or bewteen %@ and %@", [KZDateUtilities dateToString:date],
//				[KZDateUtilities dateToString:beginDate],
//				[KZDateUtilities dateToString:endDate]);
	
	beginDate = [KZDateUtilities subtractDaysFrom:beginDate by:1];
	endDate = [KZDateUtilities addDaysTo:endDate by:1];

//	NSLog(@"dateExcludingTime %@ is equal to or bewteen %@ and %@", [KZDateUtilities dateToString:date],
//				[KZDateUtilities dateToString:beginDate],
//				[KZDateUtilities dateToString:endDate]);
	
	return [KZDateUtilities dateExcludingTime:date isBetweenDate:beginDate andDate:endDate];
	
}

+(NSInteger)daysBetweenDate:(NSDate*)fromDate andDate:(NSDate*)toDate {
	
	NSDate *fd;
	NSDate *td;
	
	NSCalendar* calendar = [NSCalendar currentCalendar];
	[calendar rangeOfUnit:NSCalendarUnitDay startDate:&fd interval:NULL forDate:fromDate];
	[calendar rangeOfUnit:NSCalendarUnitDay startDate:&td interval:NULL forDate:toDate];
	
	NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fd toDate:td options:0];
	
	return [difference day];
	
}

+(NSDate*)dateWithSecondsSinceMidnight:(NSInteger)seconds {
	
	NSDate* today = [NSDate date];
	today = [KZDateUtilities timeToStartOfDay:today];
	today = [today dateByAddingTimeInterval:seconds];
	
	return today;
	
}

+(NSUInteger)dayOfWeek {
	
	return [KZDateUtilities dayOfWeekFor:[NSDate date]];
	
}

+(NSUInteger)dayOfWeekFor:(NSDate*)date {

	return [KZDateUtilities dayOfWeekFor:date startingFrom:1];
	
}

+(NSUInteger)dayOfWeekStartingFrom:(int)firstDay {

	return [KZDateUtilities dayOfWeekFor:[NSDate date] startingFrom:firstDay];
	
}

+(NSUInteger)dayOfWeekFor:(NSDate*)date startingFrom:(int)firstDay {
	
//	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//	NSLog(@"FirstWeekDay is %lu", (unsigned long)[calendar firstWeekday]);
//	NSLog(@"Set FirstWeekDay to %d", firstDay);
	[calendar setFirstWeekday:firstDay];
//	NSLog(@"FirstWeekDay is %lu", (unsigned long)[calendar firstWeekday]);
	
	NSUInteger value = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
	
	return value;
	
}

@end
