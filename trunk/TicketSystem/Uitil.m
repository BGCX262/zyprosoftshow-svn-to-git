//
//  Uitil.m
//  TicketSystem
//
//  Created by ZYVincent on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "Uitil.h"

@implementation Uitil

//将身份证字符串拆解成单个字符组成得数组 ，方法是直接从c＋＋得方法里面得到的，用oc写出来而已
+ (NSMutableArray *)returnSingleFromNSString:(NSString *)sourceString
{
    NSString *subString = nil;
    NSString *subString2 = nil;
    NSMutableArray *resultArray = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    for (int i = 0; i< [sourceString length]; i++) {
        if (i == 0) {
            [resultArray addObject:[sourceString substringToIndex:1]];
        }else{
            subString2 = [sourceString substringFromIndex:i];
            subString = [subString2 substringToIndex:1];
            [resultArray addObject:subString];
        }
        
    }
    return resultArray;
}

+ (BOOL)checkIfPersonalIDNumber:(NSString *)IDNumber
{
    NSArray *factorArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1",@"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    NSArray *checkArray = [NSArray arrayWithObjects:@"1", @"0", @"10",@"9",@"8",@"7",@"6", @"5",@"4",@"3",@"2", nil];
    
    if ([IDNumber length] != 18) {
        return FALSE;
    }
    //将身份证号字符串分解成单个字符组成得数组
    NSMutableArray *resultArray = [self returnSingleFromNSString:IDNumber];
    
    //检查是否合法
    NSInteger checkSum = 0;
    NSInteger resultNumber;
    NSInteger checkIndex;
    NSInteger checkNumber;
    
    //校验身份证得方法，网络上找得，验证有效
    for ( int i = 0; i < 17; i++) {        
        checkSum += [[resultArray objectAtIndex:i] intValue] * [[factorArray objectAtIndex:i]intValue];
    }
    resultNumber = [[resultArray objectAtIndex:17]intValue];
    checkIndex = checkSum % 11;
    checkNumber = [[checkArray objectAtIndex:checkIndex]intValue];
        
    if (resultNumber == checkNumber || ([[resultArray objectAtIndex:17] isEqualToString:@"x"]&&[[checkArray objectAtIndex:checkIndex]intValue]== 10)) {
        return YES;
    }else{
        return FALSE;
    }
}
//返回当前时间
+ (NSString*)returnCurrentDateTime
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init]autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *currentDateTime = [dateFormatter stringFromDate:[NSDate date]];
    
    return currentDateTime;
}
@end
