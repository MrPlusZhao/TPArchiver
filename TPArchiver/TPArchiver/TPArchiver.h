//
//  TPArchiver.h
//  TPArchiver
//
//  Created by MrPlusZhao on 2021/5/17.
//

#import <Foundation/Foundation.h>

@interface TPArchiver : NSObject


/// 保存数据到本地
+ (BOOL)TP_SaveData:(_Nonnull id)data Key:( NSString * _Nonnull )key;

/// 清除数据
+ (BOOL)TP_RemoveData:( NSString * _Nonnull )key;

/// 通过Key读取本地缓存 ,className 可以传 可以不传, 用来标记返回类型
+ (id _Nullable )TP_GetData:( NSString * _Nonnull )key AnyClass:(_Nullable Class)className;

@end
