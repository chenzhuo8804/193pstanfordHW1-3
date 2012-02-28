//
//  CalculatorViewController.m
//  Stanford-IOS5-Calculator
//
//  Created by Zhuo Chen on 11/20/11.
//  Copyright (c) 2011 UB. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "GraphicsViewController.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) NSMutableString* outputString;
@property (nonatomic, strong) CalculatorBrain* brain;
@property (nonatomic, strong) NSMutableDictionary* currentDictionary;
@property (nonatomic,strong) id oldStack;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize oldStack = _oldStack;
@synthesize outputString;
@synthesize display2 = _display2;
@synthesize display3 = _display3;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize currentDictionary = _currentDictionary;



-(CalculatorBrain*) brain{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //NSLog(@"CVC->prepareForSegue");
    [segue.destinationViewController setStack:self.brain.program];
    
}



-(NSMutableDictionary*) currentDictionary{
    if(!_currentDictionary) _currentDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithInt:0],@"a",
        [NSNumber numberWithInt:0],@"b",                                            
        [NSNumber numberWithInt:0],@"c",
                                                  nil];
  
    return _currentDictionary;
}

+(NSString*)descriptionOfDictionary:(NSDictionary*) dictionary{
    NSMutableString* string = [[NSMutableString alloc]init];
  
    //  NSLog([NSString stringWithFormat:@"%i",[dictionary count]]);
    for(id key in dictionary){
        [string appendFormat:@"%@%@%@ ",key,@"=",[NSString stringWithFormat:@"%g",[[dictionary valueForKey:key] doubleValue]]];  
    }
    return string;
}
- (IBAction)digitPressed:(UIButton*)sender {
    self.oldStack = self.brain.program;
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
- (IBAction)variablesPressed:(id)sender {
    self.oldStack = self.brain.program;    
    [self.brain pushVariable:[sender currentTitle]];
     self.display2.text = [CalculatorBrain descriptionOfProgram:[self brain].program];

}

- (IBAction)enterPressed {
    /*  NSLog([NSString stringWithFormat:@"%g",[self.display.text doubleValue]]); */
       // NSLog(@"123");
    self.oldStack = [self.brain program];
   // NSLog([NSString stringWithFormat:@"%i",[self.oldStack count]]);
    //Good !
        self.display2.text = [CalculatorBrain descriptionOfProgram:[self brain].program];
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.display2.text = [CalculatorBrain descriptionOfProgram:[self brain].program];  
}

-(void)updateDisplays{    
}

- (IBAction)opeartionPressed:(UIButton*)sender {
    self.oldStack = [self.brain program];
    if(self.userIsInTheMiddleOfEnteringANumber)
    [self enterPressed];     
   //ƒn NSLog([[self class] descriptionOfDictionary:self.currentDictionary]);
    double result = [self.brain performOperation:sender.currentTitle usingVariables:self.currentDictionary];
    if(![@"Enter" isEqualToString:sender.currentTitle]){        
    }
    NSString* resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
     self.display2.text = [CalculatorBrain descriptionOfProgram:[self brain].program];    
}

- (IBAction)undoPressed:(id)sender {       
    
    if(self.userIsInTheMiddleOfEnteringANumber){
        NSString* str = self.display.text;
        self.display.text = [str substringToIndex:str.length -1]; 
    }
    else 
        [self.brain undo];
    double result = [CalculatorBrain popOperandOffProgramStack:self.brain.program usingVariableValues:self.currentDictionary];
    self.display.text = [NSString stringWithFormat:@"%g",result];   
    self.display2.text = [CalculatorBrain descriptionOfProgram:self.brain.program];
}











- (IBAction)clearPressed:(id)sender {
    [self.brain clearOperandStack];
    self.display.text = @"0";
    self.display2.text = @"";    
}



- (void)viewDidUnload {
    [self setDisplay2:nil];
    [self setDisplay3:nil];
    [super viewDidUnload];
}
@end
