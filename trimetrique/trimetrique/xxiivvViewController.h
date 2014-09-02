//
//  xxiivvViewController.h
//  trimetrique
//
//  Created by Devine Lu Linvega on 2014-09-01.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xxiivvViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *brushWrapper;

@property (strong, nonatomic) IBOutlet UIView *brushVertex1;
@property (strong, nonatomic) IBOutlet UIView *brushVertex2;
@property (strong, nonatomic) IBOutlet UIView *brushVertex3;

@property (strong, nonatomic) IBOutlet UIView *interfaceWrapper;
@property (strong, nonatomic) IBOutlet UITextField *textInput;
@property (strong, nonatomic) IBOutlet UIButton *toggleInterface;
@property (strong, nonatomic) IBOutlet UIButton *toggleLineWidth;
@property (strong, nonatomic) IBOutlet UIButton *toggleLineStyle;
@property (strong, nonatomic) IBOutlet UIButton *toggleLineSpeed;
@property (strong, nonatomic) IBOutlet UIButton *toggleLineColor;

- (IBAction)toggleInterface:(id)sender;
- (IBAction)toggleLineWidth:(id)sender;
- (IBAction)toggleLineStyle:(id)sender;
- (IBAction)toggleLineSpeed:(id)sender;
- (IBAction)toggleLineColor:(id)sender;

@end


float tileSize;
float screenWidth;
float screenHeight;

float letterWidth;

int currentIndex;
int currentSegment;

NSTimer *textPrint;