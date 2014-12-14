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

@property (strong, nonatomic) IBOutlet UIView *guideWidthLeft;
@property (strong, nonatomic) IBOutlet UIView *guideWidthRight;

@property (strong, nonatomic) IBOutlet UIView *previewLineColor;
@property (strong, nonatomic) IBOutlet UIView *previewLineStyle;
@property (strong, nonatomic) IBOutlet UIView *previewLineWidth;

@property (strong, nonatomic) IBOutlet UILabel *textLineColor;
@property (strong, nonatomic) IBOutlet UIView *optionLineColor;
@property (strong, nonatomic) IBOutlet UIView *optionLineStyle;

@property (strong, nonatomic) IBOutlet UILabel *textLineStyle;
@property (strong, nonatomic) IBOutlet UIView *optionLineWidth;
@property (strong, nonatomic) IBOutlet UILabel *textLineWidth;
@property (strong, nonatomic) IBOutlet UIView *optionLineSpeed;
@property (strong, nonatomic) IBOutlet UILabel *textLineSpeed;
@property (strong, nonatomic) IBOutlet UIView *previewLineSpeed;

@property (strong, nonatomic) IBOutlet UIView *optionText;
@property (strong, nonatomic) IBOutlet UILabel *previewtext;


- (IBAction)toggleInterface:(id)sender;
- (IBAction)toggleLineWidth:(id)sender;
- (IBAction)toggleLineStyle:(id)sender;
- (IBAction)toggleLineSpeed:(id)sender;
- (IBAction)toggleLineColor:(id)sender;

@end

float tileSize;
float screenWidth;
float screenHeight;

float letterSpeed;
float letterWidth;
float letterRounded;
float letterColor;

int currentIndex;
int currentSegment;

NSTimer *textPrint;