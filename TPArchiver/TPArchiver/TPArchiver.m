//
//  TPArchiver.m
//  TPArchiver
//
//  Created by MrPlusZhao on 2021/5/17.
//

#import "TPArchiver.h"

//获取Cache目录路径
#define Cache_Path       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@implementation TPArchiver

//防止备份到iTunes和iCloud(上架审核必备)
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    if ([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]) {
        NSError *error = nil;
        BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    }
    return YES;
}


+ (NSString*)checkAndCreatePath:(NSString*)pathKey{
    NSString *path = [[Cache_Path stringByAppendingPathComponent:pathKey] stringByAppendingString:@".plist"];//获取路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断是否存在，不存在则创建路径
    if (![fileManager fileExistsAtPath:path]) {
        BOOL success = [fileManager createFileAtPath:path contents:nil attributes:nil];
        if (success) {
            NSLog(@"👍🏻路径创建成功👍🏻 %@",path);
            return path;
        }
        else{
            NSLog(@"⚠️路径创建失败⚠️ %@",path);
            return @"";
        }
    }
    else{
        return path;
    }
}
+ (NSString*)checkPath:(NSString*)pathKey{
    NSString *path = [[Cache_Path stringByAppendingPathComponent:pathKey] stringByAppendingString:@".plist"];//获取路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断是否存在，不存在则创建路径
    if (![fileManager fileExistsAtPath:path]) {
        return @"";
    }
    else{
        return path;
    }
}

#pragma mark 缓存数据
+ (BOOL)TP_SaveData:(_Nonnull id)data Key:( NSString * _Nonnull )key{
    NSString *path = [TPArchiver checkAndCreatePath:key];
    if (![path length]) {return NO;}
    BOOL success;
    NSData *cacheData;
    NSError *error;
    if (@available(iOS 11.0, *)) {
        cacheData = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:&error];
    }
    else{
        cacheData = [NSKeyedArchiver archivedDataWithRootObject:data];
    }
    success = [cacheData writeToFile:path atomically:YES];
    if (success) {
        [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
        NSLog(@"%@ 缓存成功",path);
    }
    else{
        if (error) {
            NSLog(@"%@",error.description);
        }
    }
    return success;
}

#pragma mark 清除缓存
+ (BOOL)TP_RemoveData:( NSString * _Nonnull )key{
    NSString *path = [TPArchiver checkPath:key];
    if ([path length]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        return [fileManager removeItemAtPath:path error:nil];
    }
    else{
        return NO;
    }
}

#pragma mark 读取缓存
+ (id _Nullable )TP_GetData:( NSString * _Nonnull )key AnyClass:(_Nullable Class)className{
    NSString *path = [TPArchiver checkPath:key];
    if ([path length]) {
        id object;
        NSError *error;
        if (@available(iOS 11.0, *)) {
            NSSet *set = [NSSet setWithArray:@[[NSArray class],
                                               [NSDictionary class],
                                               [NSString class],
                                               [NSNumber class],
                                               [NSData class]]];
            object = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:[NSData dataWithContentsOfFile:path] error:&error];
            if (error) {
                NSLog(@"%@",error.description);
                object = nil;
            }
            return object ? : (className ? [className new] : nil);
        }
        else{
            object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            return object ? : (className ? [className new] : nil);
        }
    }
    else{
        return className ? [className new] : nil;
    }
}

@end
