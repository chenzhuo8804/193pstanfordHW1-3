//
//  CalculatorBrain.h
//  Stanford-IOS5-Calculator
//
//  Created by Zhuo Chen on 11/20/11.
//  Copyright (c) 2011 UB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

/* Clear the current opeand stack */
-(void)clearOperandStack;

/* Push operand to the current stack */
-(void)pushOperand:(double)operand;

/* Perform operation using current operand stack */
-(double)performOpeartion:(NSString*)operation;

@end
