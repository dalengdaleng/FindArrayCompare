//
//  ViewController.m
//  FindArrayCompare
//
//  Created by ios on 16/8/16.
//  Copyright © 2016年 KyleWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //遍历一个数组看谁快
    //ForLoop, For - in, enumerateObjectsUsingBlock
    [self findOneArray];
    
    //通过Value查找Index看谁快
    //For - in, enumerateObjectsUsingBlock, enumerateObjectsWithOptions
    [self findKeyValue];
    
    //要遍历字典
    //For-in 和 enumerateKeysAndObjectsUsingBlock
    [self findDictionary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)findOneArray
{
    NSMutableArray *test = [NSMutableArray array];
    for (int i = 0; i < 1000000; i ++) {
        [test addObject:@(i)];
    }
    
    __block int sum = 0;
    double date_s = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < test.count; i ++) {
        sum += [test[i] integerValue];
    }
    double date_current = CFAbsoluteTimeGetCurrent() - date_s;
    NSLog(@"Sum : %d ForLoop Time: %f ms",sum,date_current * 1000);
    
    
    sum = 0;
    date_s = CFAbsoluteTimeGetCurrent();
    for (NSNumber *num in test) {
        sum += [num integerValue];
    }
    date_current = CFAbsoluteTimeGetCurrent() - date_s;
    NSLog(@"Sum : %d For-in Time: %f ms",sum,date_current * 1000);
    
    
    sum = 0;
    date_s = CFAbsoluteTimeGetCurrent();
    [test enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        sum += [obj integerValue];
    }];
    date_current = CFAbsoluteTimeGetCurrent() - date_s;
    NSLog(@"Sum : %d enumrateBlock Time: %f ms",sum,date_current * 1000);
}

- (void)findKeyValue
{
    NSMutableArray *test = [NSMutableArray array];
    for (int i = 0; i < 10000000; i ++) {
        [test addObject:@(i + 10)];
    }
    
    //For-in
    __block NSInteger index = 0;
    double date_s = CFAbsoluteTimeGetCurrent();
    for (NSNumber *num in test) {
        if ([num integerValue] == 9999999) {
            index = [test indexOfObject:num];
            break;
        }
    }
    double date_current = CFAbsoluteTimeGetCurrent() - date_s;
    NSLog(@"index : %ld For-in Time: %f ms",(long)index,date_current * 1000);
    
    //enumerateObjectsUsingBlock
    index = 0;
    date_s = CFAbsoluteTimeGetCurrent();
    [test enumerateObjectsUsingBlock:^(id num, NSUInteger idx, BOOL *stop) {
        if ([num integerValue] == 9999999) {
            index = idx;
            *stop = YES;
        }
    }];
    date_current = CFAbsoluteTimeGetCurrent() - date_s;
    NSLog(@"index : %ld enumerateBlock Time: %f ms",(long)index,date_current * 1000);
    
    //enumerateObjectsWithOptions
    index = 0;
    date_s = CFAbsoluteTimeGetCurrent();
    [test enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id num, NSUInteger idx, BOOL *stop) {
        if ([num integerValue] == 9999999) {
            index = idx;
            *stop = YES;
        }
    }];
    date_current = CFAbsoluteTimeGetCurrent() - date_s;
    NSLog(@"index : %ld enumerateObjectsWithOptions Time: %f ms",(long)index,date_current * 1000);
}

- (void)findDictionary
{
    NSDictionary *testDictionary = @{
                                     @"Auther" : @"yyyyy",
                                     @"Game" : @"Dota",
                                     @"App" : @"dddddd",
                                     @"Market" : @"AppStore"
                                     };
    
    //For - in
    NSMutableArray *forInArry = [NSMutableArray array];
    double date_s = CFAbsoluteTimeGetCurrent();
    NSArray *keys = [testDictionary  allKeys];
    for (NSString *key in keys) {
        NSString *Value = testDictionary[key];
        [forInArry addObject:Value];
    }
    double date_current = CFAbsoluteTimeGetCurrent() - date_s;
    NSLog(@"index : %ld For-in Time: %f ms",(long)index,date_current * 1000);
    
    //enumerateKeysAndObjectsUsingBlock
    date_s = CFAbsoluteTimeGetCurrent();
    NSMutableArray *enumArry = [NSMutableArray array];
    [testDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [enumArry addObject:obj];
    }];
    date_current = CFAbsoluteTimeGetCurrent() - date_s;
    NSLog(@"index : %ld For-in Time: %f ms",(long)index,date_current * 1000);
    
    NSLog(@"ForInArr: %@",forInArry);
    NSLog(@"enumArry: %@",enumArry);
}
@end
