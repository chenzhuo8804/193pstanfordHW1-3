//
//  CalculatorBrain.m
//  Stanford-IOS5-Calculator
//
//  Created by Zhuo Chen on 11/20/11.
//  Copyright (c) 2011 UB. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray* operandStack;
@end

@implementation CalculatorBrain
@synthesize  operandStack = _operandStack;

/* return the operand Stack, if it is nil, make one and return */
-(NSMutableArray*) operandStack{
    if(_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}


/* Clear the current operandStack */
-(void)clearOperandStack{
    [self.operandStack removeAllObjects];
}


/* Pop the last object in the operand Stack and return it */
-(double)popOperand{
    NSNumber* operandObject = [self.operandStack lastObject];
    if(operandObject != nil){
        [self.operandStack removeLastObject];
    }
    return operandObject.doubleValue;
}


/* Set the current operand Stack to another one */
-(void)setOperandStack:(NSMutableArray *)operandStack{
    _operandStack = operandStack;
}


/* Push the operand to current operand stack */
-(void)pushOperand:(double)operand{ 
    
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];    
  //  NSNumber* number = self.operandStack.lastObject;
  //  NSLog([NSString stringWithFormat:@"%g",number.doubleValue]);
}


/* Perform the operation using the operand in the stack */
-(double)performOpeartion:(NSString*)operation{
    double result = 0;
    
    if([operation isEqualToString:@"+"]){
        result = [self popOperand] + [self popOperand];
    } else if([@"*" isEqualToString:operation]){
        result = [self popOperand] * [self popOperand];
    } else if([@"-" isEqualToString:operation]){
        result = [self popOperand] - [self popOperand];
    } else if([@"/" isEqualToString:operation]){
        double num1 = [self popOperand];
        double num2 = [self popOperand];
        if(num1){
            result = num2/ num1;   //avoid 0 in dividing
        } else{
            result = 0;
        }        
    } else if([@"sin" isEqualToString:operation]){
        result = sin([self popOperand]);
    } else if([@"cos" isEqualToString:operation]){
        result = cos([self popOperand]);
    } else if([@"pi" isEqualToString:operation]){
        [self pushOperand:3.14];
        result = 3.14;
    } else if([@"sqrt" isEqualToString:operation]){
        double num = [self popOperand];
        if(num){   //if the number being sqrted is 0, return 0
            result = sqrt(num);
        } else{
            result = 0;
        }
    }   
    
    //calculate result
    return result;
}
@end
