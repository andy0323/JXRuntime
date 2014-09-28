//
//  JXObject.h
//  JXRuntime
//
//  Created by andy on 9/28/14.
//  Copyright (c) 2014 JianXiang Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXObject : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) NSInteger age;

- (void)funcOne;
- (void)funcTwo;
- (void)funcThree;
- (void)funcFour;
- (void)funcFive;

@end
