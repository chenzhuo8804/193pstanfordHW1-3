//
//  CalculatorViewController.m
//  Stanford-IOS5-Calculator
//
//  Created by Zhuo Chen on 11/20/11.
//  Copyright (c) 2011 UB. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) NSMutableString* outputString;
@property (nonatomic, strong) CalculatorBrain* brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize outputString;
@synthesize display2 = _display2;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(CalculatorBrain*) brain{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}


/* Digit Pressed :
 * if the user is in the middle of typing
 * number , then add the digit to be part of
 * it, i.e. press 3 when a 4 is on the screen
 * would make it 34
 * else just add the current number to the dislay
 */
- (IBAction)digitPressed:(UIButton*)sender {
    NSString* digit = sender.currentTitle;
    if(self.userIsInTheMiddleOfEnteringANumber){
        if([@"." isEqualToString:[[sender titleLabel] text]]){  // . 
            NSRange range = [self.display.text rangeOfString:@"."];
            if(range.location == NSNotFound){
              self.display.text = [self.display.text stringByAppendingString:digit];        
            }                
        }
        else{ //Case for numbers
            self.display.text = [self.display.text stringByAppendingString:digit];  
        }    
    } else{
        if([@"." isEqualToString:[[sender titleLabel] text]]){  // . 
            self.display.text = @"";
            self.display.text = [self.display.text stringByAppendingString:digit];                          
        }
        else{
            self.display.text = digit;
        }
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}



/* Enter Pressed :
 * Push the current number into the stack, 
 * and update the display 
 */
- (IBAction)enterPressed {
      self.display2.text = [self.display2.text stringByAppendingFormat:@"%g ",self.display.text.doubleValue];
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;    
}




/* Operation Pressed:
 * If user is in the middle of typeing a number , 
 * then pressed the number into the stack first 
 * and perform opeartion. 
 * Else perform opeartion directly 
 */
- (IBAction)opeartionPressed:(UIButton*)sender {
    if(self.userIsInTheMiddleOfEnteringANumber)
    [self enterPressed];       
    double result = [self.brain performOpeartion:sender.currentTitle];
    if(![@"Enter" isEqualToString:sender.currentTitle]){
        self.display2.text = [[self.display2.text stringByAppendingString:sender.currentTitle] stringByAppendingString:@" "];
    }
    NSString* resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    
}


/* Clear Pressed :
 * clean stack and displayes
 */
- (IBAction)clearPressed:(id)sender {
    [self.brain clearOperandStack];
    self.display.text = @"0";
    self.display2.text = @"";
    
}



- (void)viewDidUnload {
    [self setDisplay2:nil];
    [super viewDidUnload];
}
@end
