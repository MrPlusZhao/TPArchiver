# TPArchiver
TPArchiver

# 主要方法
``` 
/// 保存数据到本地
+ (BOOL)TP_SaveData:(_Nonnull id)data Key:( NSString * _Nonnull )key;

/// 清除数据
+ (BOOL)TP_RemoveData:( NSString * _Nonnull )key;

/// 通过Key读取本地缓存 ,className 可以传 可以不传, 用来标记返回类型
+ (id _Nullable )TP_GetData:( NSString * _Nonnull )key AnyClass:(_Nullable Class)className;

```

# 用法实践

```
    [TPArchiver TP_SaveData:@[@"444",@"2",@"3"] Key:@"test111"];
    [TPArchiver TP_SaveData:@{@"111":@"333",@"444":@"555"} Key:@"test222"];
    [TPArchiver TP_SaveData:@"哈哈哈哈哈" Key:@"test333"];

    id obj1 = [TPArchiver TP_GetData:@"test11133" AnyClass:[NSArray class]]; // 如果取不到数值, 就返回空数组
    id obj2 = [TPArchiver TP_GetData:@"test222xxxx" AnyClass:nil];// 如果取不到值, 就返回nil
    id obj3 = [TPArchiver TP_GetData:@"test333" AnyClass:nil];

    NSLog(@"%@",obj1);
    NSLog(@"%@",obj2);
    NSLog(@"%@",obj3);
    
    [TPArchiver TP_RemoveData:@"test111"];
    [TPArchiver TP_RemoveData:@"test222"];
```
