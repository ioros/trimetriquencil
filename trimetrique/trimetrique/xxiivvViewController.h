//
//  xxiivvViewController.h
//  trimetrique
//
//  Created by Devine Lu Linvega on 2014-09-01.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xxiivvViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *brushWrapper;

@property (strong, nonatomic) IBOutlet UIView *brushVertex1;
@property (strong, nonatomic) IBOutlet UIView *brushVertex2;
@property (strong, nonatomic) IBOutlet UIView *brushVertex3;
@property (strong, nonatomic) IBOutlet UIView *brushVertex4;
@property (strong, nonatomic) IBOutlet UIView *brushVertex5;


@property (strong, nonatomic) IBOutlet UIView *interfaceWrapper;



@end


float tileSize;
float screenWidth;
float screenHeight;

float letterWidth;

int currentIndex;
int currentSegment;