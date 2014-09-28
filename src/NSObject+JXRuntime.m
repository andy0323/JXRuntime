////
//  NSObject+Class.m
//  JXRuntime
//
//  Created by andy on 9/22/14.
//  Copyright (c) 2014 JianXiang Jin. All rights reserved.
//

#import "NSObject+JXRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (JXRuntime)

/**
 *  更换对象的类
 */
- (void)setClass:(Class)myClass
{
    object_setClass(self, [myClass class]);
}

/**
 *  获取对象所属类所有方法
 */
- (void)getAllMethods:(void (^)(NSArray *methods))block
{
    NSMutableArray *arr = [NSMutableArray array];
    
    u_int count;
    Method *methods = class_copyMethodList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        SEL method = method_getName(methods[i]);
        NSString *name = NSStringFromSelector(method);
        [arr addObject:name];
    }
    
    block(arr);
}

/**
 *  获取对象所属类所有属性
 */
- (void)getAllProperties:(void (^)(NSDictionary *properties))block
{
    NSMutableDictionary *returnValue=[[NSMutableDictionary alloc] init];

    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char* propertyName = property_getName(property);
        
        //字段的属性
        NSString *proty = [NSString stringWithFormat:@"%s",property_getAttributes(property)];
        
        //字段的名称
        NSString *name  = [NSString stringWithFormat:@"%s",property_getName(property)];

        //判断是否有字段对应的get方法
        SEL selector = NSSelectorFromString([NSString stringWithUTF8String:propertyName]);
        
        if ([self respondsToSelector:selector])
        {
            NSString *class_type = [proty substringToIndex:2];
            
            // 判断类型
            if ([class_type isEqualToString:@"Td"]) // Double
            {
                IMP myImp1 = [self methodForSelector:selector];
                double str = ((double (*) (id,SEL))myImp1)(self,selector);
                [returnValue setObject:[NSString stringWithFormat:@"%f",str] forKey:name];
            }
            else if ([class_type isEqualToString:@"Tf"]) // Float
            {
                IMP myImp1 = [self methodForSelector:selector];
                float str = ((float (*) (id,SEL))myImp1)(self,selector);
                [returnValue setObject:[NSString stringWithFormat:@"%f",str] forKey:name];
            }
            else if ([class_type isEqualToString:@"Tc"]) // Char
            {
                IMP myImp1 = [self methodForSelector:selector];
                BOOL str = ((BOOL (*) (id,SEL))myImp1)(self,selector);
                
                [returnValue setObject:[NSString stringWithFormat:@"%d",str] forKey:name];
            }
            else if ([class_type isEqualToString:@"Ti"]) // Int
            {
                IMP myImp1 = [self methodForSelector:selector];
                int str = ((int (*) (id,SEL))myImp1)(self,selector);
                
                [returnValue setObject:[NSString stringWithFormat:@"%d",str] forKey:name];
            }
            else
            {
                //调用get方法
                id str = [self performSelector:selector];
                if (str!=nil)
                {
                    
                    if ([class_type isEqualToString:@"Tl"]) {
                        // long类型字段
                        [returnValue setObject:[NSString stringWithFormat:@"%ld",(long)str] forKey:name];
                    }else if ([class_type isEqualToString:@"T@"]) {
                        if ([proty length]>12 && [[proty substringToIndex:12] isEqualToString:@"T@\"NSString\""])
                        {
                            // NSString 类型字段
                            [returnValue setObject:[NSString stringWithFormat:@"%@",str] forKey:name];
                        }
                    }
                    else if ([class_type isEqualToString:@"TB"]) {
                        // bool类型字段
                        [returnValue setObject:[NSString stringWithFormat:@"%d",(NSInteger)str] forKey:name];
                        continue;
                    }else {
                        NSLog(@"不支持的字段类型!%@",class_type);
                    }
                }
            }
        }
    }
    free(properties);
    block(returnValue);
}

/**
 *  覆盖方法
 */
- (void)replaceMethod:(SEL)method by:(IMP)replaceMethod types:(const char *)types
{
    class_replaceMethod([self class], method, replaceMethod, types);
}

/**
 *  替换对象方法
 */
- (void)exchangeMethod:(SEL)method by:(SEL)exchangeMethod from:(NSObject *)target
{
    Method m1 = class_getInstanceMethod([self class]  , method);
    Method m2 = class_getInstanceMethod([target class], exchangeMethod);
    method_exchangeImplementations(m1, m2);
}
@end
