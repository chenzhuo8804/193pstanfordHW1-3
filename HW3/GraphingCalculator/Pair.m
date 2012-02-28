//
//  Pair.m
//  GraphingCalculator
//
//  Created by Zhuo Chen on 1/5/12.
//  Copyright (c) 2012 UB. All rights reserved.
//

#import "Pair.h"

@implementation Pair
@synthesize var1;
@synthesize var2;

-(id)init{
    self = [super init];
    if(self){}
    return self;
}




+(id)initWithVar1:(double)Var1 Var2:(double)Var2{
    Pair* par = [[Pair alloc] init];
    par.var1 = Var1;
    par.var2 = Var2;
    return par;    
}
@end
