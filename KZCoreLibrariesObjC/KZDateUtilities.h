//
//  KZDateLibrary.h
//  TestClassSheet
//
//  Created by Shane Whitehead on 1/10/2014.
//  Copyright (c) 2014 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZDateUtilities : NSObject
+(NSDate*)subtractMonthsFrom:(NSDate*)date by:(NSInteger)amount;
+(NSDate*)addMonthsFrom:(NSDate*)date by:(NSInteger)amount;
+(NSDate *)subtractDaysFrom:(NSDate*)date by:(NSInteger)amount;
+(NSDate *)addDaysTo:(NSDate*)date by:(NSInteger)amount;
+(BOOL)isDate:(NSDate*)date before:(NSDate*)before;
+(BOOL)isDate:(NSDate*)date after:(NSDate*)after;
+(NSDate*)createDateWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day;
+(NSDate*)createDateWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day beforeMidnight:(BOOL)beforeMidnight;
+(NSDate *)timeToEndOfDay:(NSDate*)date;
+(NSDate *)timeToStartOfDay:(NSDate*)date;
+(BOOL)dateExcludingTime:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
+(BOOL)dateExcludingTime:(NSDate*)date isEqualToOrAfterDate:(NSDate*)beginDate andEqualToOrBeforeDate:(NSDate*)endDate;
+(NSString*)dateToString:(NSDate*) date;
+(NSString*)dateTimeToString:(NSDate*) date;
+(NSInteger)daysBetweenDate:(NSDate*)fromDate andDate:(NSDate*)toDate;
+(NSDate*)dateWithSecondsSinceMidnight:(NSInteger)seconds;
+(NSUInteger)dayOfWeek;
+(NSUInteger)dayOfWeekFor:(NSDate*)date;
+(NSUInteger)dayOfWeekStartingFrom:(int)firstDay;
+(NSUInteger)dayOfWeekFor:(NSDate*)date startingFrom:(int)firstDay;
@end
