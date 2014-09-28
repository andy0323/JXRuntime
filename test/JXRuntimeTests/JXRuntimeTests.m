//
//  JXRuntimeTests.m
//  JXRuntimeTests
//
//  Created by andy on 9/17/14.
//  Copyright (c) 2014 JianXiang Jin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+JXRuntime.h"
#import "JXObject.h"
#import "JXTestObject.h"
#import <objc/runtime.h>
@interface JXRuntimeTests : XCTestCase
{
    JXObject *_obj;
    JXTestObject *_testObj;
}
@end

@implementation JXRuntimeTests

- (void)setUp
{
    [super setUp];

    _obj = [[JXObject alloc] init];
    
    _obj.name = @"Andy Jin";
    _obj.city = @"BeiJing";
    _obj.age = 24;

    _testObj = [[JXTestObject alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetAllMethods
{
    [_obj getAllMethods:^(NSArray *methods) {
    
        
    }];
}

- (void)testSetClass
{
    [_obj setClass:[JXTestObject class]];
    
    [_obj funcOne];
}

- (void)testGetProperty
{
    [_obj getAllProperties:^(NSDictionary *properties) {
        
        NSLog(@"%@", properties);
        
    }];
}

- (void)testReplaceMethod
{
    [_obj replaceMethod:@selector(funcOne) by:(IMP)replaceMethod types:""];
    [_obj funcOne];
}
void replaceMethod()
{
    NSLog(@"Hello World");
}

- (void)testExchangeMethod
{
    [_obj exchangeMethod:@selector(funcOne) by:@selector(funcOne) from:_testObj];
    [_obj funcOne];
}
@end
