//
//  ViewController.m
//  TPArchiver
//
//  Created by MrPlusZhao on 2021/5/17.
//

#import "ViewController.h"
#import "TPArchiver/TPArchiver.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [TPArchiver TP_SaveData:@[@"444",@"2",@"3"] Key:@"test111"];
    [TPArchiver TP_SaveData:@{@"111":@"333",@"444":@"555"} Key:@"test222"];
    [TPArchiver TP_SaveData:@"哈哈哈哈哈" Key:@"test333"];

    id obj1 = [TPArchiver TP_GetData:@"test11133" AnyClass:[NSArray class]];
    id obj2 = [TPArchiver TP_GetData:@"test222xxxx" AnyClass:nil];
    id obj3 = [TPArchiver TP_GetData:@"test333" AnyClass:nil];

    NSLog(@"%@",obj1);
    NSLog(@"%@",obj2);
    NSLog(@"%@",obj3);
    
    [TPArchiver TP_RemoveData:@"test111"];
    [TPArchiver TP_RemoveData:@"test222"];

}


@end
