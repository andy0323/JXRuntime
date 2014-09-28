//
//  NSObject+Class.h
//  JXRuntime
//
//  Created by andy on 9/22/14.
//  Copyright (c) 2014 JianXiang Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JXRuntime)
/**
 *  更换对象的类
 *
 *  @param myClass 更换的类
 */
- (void)setClass:(Class)myClass;

/**
 *  获取对象所属类所有方法
 *
 *  @param block 返回函数数组
 */
- (void)getAllMethods:(void (^)(NSArray *methods))block;

/**
 *  获取对象所属类所有属性
 *
 *  @param block 返回属性字典
 */
- (void)getAllProperties:(void (^)(NSDictionary *properties))block;

/**
 *  覆盖对象所属类方法
 *
 *  @param method        对象的函数
 *  @param replaceMethod 替换的函数
 *  @param types         替换函数结构
 */
- (void)replaceMethod:(SEL)method
                   by:(IMP)replaceMethod
                types:(const char *)types;

/**
 *  替换对象方法
 *
 *  @param method         需要替换的函数
 *  @param exchangeMethod 替换的函数
 *  @param target         持有替换函数的对象
 */
- (void)exchangeMethod:(SEL)method by:(SEL)exchangeMethod from:(NSObject *)target;
@end
