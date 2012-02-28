//
//  Pair.h
//  GraphingCalculator
//
//  Created by Zhuo Chen on 1/5/12.
//  Copyright (c) 2012 UB. All rights reserved.
//

#import <Foundation/Foundation.h>
struct sPair{
    double var1;
    double var2;
};


@interface Pair : NSObject

@property (nonatomic) double var1;
@property (nonatomic) double var2;


+(id)initWithVar1:(double)var1 Var2:(double)var2;
@end
