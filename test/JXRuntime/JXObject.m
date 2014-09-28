//
//  JXObject.m
//  JXRuntime
//
//  Created by andy on 9/28/14.
//  Copyright (c) 2014 JianXiang Jin. All rights reserved.
//

#import "JXObject.h"

@implementation JXObject

- (void)funcOne
{
    NSLog(@"JXObject: %@", NSStringFromSelector(_cmd));
}

- (void)funcTwo
{
    NSLog(@"JXObject: %@", NSStringFromSelector(_cmd));
}

- (void)funcThree
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)funcFour
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)funcFive
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
@end
