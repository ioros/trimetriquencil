//
//  xxiivvViewController.m
//  trimetrique
//
//  Created by Devine Lu Linvega on 2014-09-01.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

#import "xxiivvViewController.h"

@interface xxiivvViewController ()

@end

@implementation xxiivvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self start];
}

-(void)start
{
	tileSize = self.view.frame.size.width/8;
	screenWidth = self.view.frame.size.width;
	screenHeight = self.view.frame.size.height;
	
	letterSpeed = 0.5;
	letterWidth = tileSize/2;
	letterRounded = 1;
	letterColor = 0;
	
	[self templateStart];
	[self renderText:@""];
}

-(void)templateStart
{
	self.brushWrapper.frame = CGRectMake( (screenWidth/2)-(letterWidth/2), tileSize, letterWidth, screenHeight-(2*tileSize));
	
	if( letterRounded == 1 ){
		_brushVertex1.layer.cornerRadius = letterWidth/2;
		_brushVertex2.layer.cornerRadius = letterWidth/2;
		_brushVertex3.layer.cornerRadius = letterWidth/2;
	}
	else{
		_brushVertex1.layer.cornerRadius = 0;
		_brushVertex2.layer.cornerRadius = 0;
		_brushVertex3.layer.cornerRadius = 0;
	}
	
	_toggleInterface.frame = CGRectMake(0, tileSize, screenWidth, screenHeight-tileSize);
	
	_guideWidthLeft.frame = CGRectMake( (screenWidth/2)+(letterWidth/2), 0, 1, screenHeight);
	_guideWidthRight.frame = CGRectMake( (screenWidth/2)-(letterWidth/2)-1, 0, 1, screenHeight);
	
	_guideWidthLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tile.png"]];
	_guideWidthRight.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tile.png"]];
	
	// Color
	
	UIColor * colorTarget = [UIColor whiteColor];
	if( letterColor == 2 ){ colorTarget = [UIColor colorWithRed:0 green:1 blue:0.75 alpha:1]; }
	if( letterColor == 1 ){ colorTarget = [UIColor colorWithRed:1 green:0 blue:0 alpha:1]; }
	if( letterColor == 0 ){ colorTarget = [UIColor redColor]; }
	
	_optionLineColor.frame = CGRectMake(0, screenHeight-(2*tileSize), screenWidth/2, tileSize);
	_textLineColor.frame = CGRectMake(tileSize, 0, screenWidth/2, tileSize);
	
	_toggleLineColor.frame = CGRectMake(0, 0, screenWidth/2, tileSize);

	_previewLineColor.backgroundColor = colorTarget;
	_previewLineColor.frame = CGRectMake((tileSize/2)-7, (tileSize/2)-7, tileSize/3, tileSize/3);
	
	// Style
	
	if(letterRounded == 1){
		_previewLineStyle.layer.cornerRadius = tileSize/3/2;
	}
	else{
		_previewLineStyle.layer.cornerRadius = 0;
	}
	
	_previewLineStyle.backgroundColor = [UIColor grayColor];
	
	_optionLineStyle.frame = CGRectMake(0, screenHeight-(3*tileSize), screenWidth/2, tileSize);
	_textLineStyle.frame = CGRectMake(tileSize, 0, screenWidth/2, tileSize);
	
	_toggleLineStyle.frame = CGRectMake(0, 0, screenWidth/2, tileSize);
	
	_previewLineStyle.backgroundColor = [UIColor whiteColor];
	_previewLineStyle.frame = CGRectMake((tileSize/2)-7, (tileSize/2)-7, tileSize/3, tileSize/3);
	
	// Width
	
	if(letterWidth == tileSize/2){
		_previewLineWidth.frame = CGRectMake((tileSize/2)-7, (tileSize/2)-7, tileSize/3, tileSize/3);
	}
	else{
		_previewLineWidth.frame =CGRectMake((tileSize/2)-7, (tileSize/2)-7, tileSize/6, tileSize/3);
	}
	
	_optionLineWidth.frame = CGRectMake(0, screenHeight-(4*tileSize), screenWidth/2, tileSize);
	_textLineWidth.frame = CGRectMake(tileSize, 0, screenWidth/2, tileSize);
	
	_toggleLineWidth.frame = CGRectMake(0, 0, screenWidth/2, tileSize);
	
	_previewLineWidth.backgroundColor = [UIColor whiteColor];
	_previewLineWidth.layer.cornerRadius = 3;
	
	// Speed
	
	_previewLineSpeed.backgroundColor = [UIColor redColor];
	
	if( letterSpeed == 1 ){
		_previewLineSpeed.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"speed_fast.png"]];
	}
	else{
		_previewLineSpeed.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"speed_slow.png"]];
	}
	
	_optionLineSpeed.frame = CGRectMake(0, screenHeight-(5*tileSize), screenWidth/2, tileSize);
	_textLineSpeed.frame = CGRectMake(tileSize, 0, screenWidth/2, tileSize);
	
	_toggleLineSpeed.frame = CGRectMake(0, 0, screenWidth/2, tileSize);
	
	_previewLineSpeed.frame = CGRectMake((tileSize/2)-7, (tileSize/2)-7, tileSize/3, tileSize/3);
	
	// text
	
	_optionText.frame = CGRectMake(0, screenHeight-(1*tileSize), screenWidth, tileSize);
	_previewtext.frame = CGRectMake((tileSize/2)-7, (tileSize/2)-7, tileSize/3, tileSize/3);
	
	_textInput.frame = CGRectMake(tileSize, 0, screenWidth-(2*tileSize), tileSize);
	[_textInput setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
	
}

-(void)renderText :(NSString*)text
{
	text = [text lowercaseString];
	[textPrint invalidate];
	if(![text isEqualToString:@""] ){
		textPrint = [NSTimer scheduledTimerWithTimeInterval: letterSpeed target: self selector:@selector(renderTextTrigger:) userInfo: text repeats:YES];
	}
}

-(void)renderTextTrigger :(NSTimer *)timer
{
	NSString * text = [timer userInfo];
	NSString * targetLetter = [NSString stringWithFormat:@"%C", [text characterAtIndex:(currentIndex % [text length])] ];
	[self renderLetter:targetLetter];
}

-(void)renderLetter:(NSString *)letter
{
	[NSTimer scheduledTimerWithTimeInterval: (letterSpeed/6)*1 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterSpeed/6)*2 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterSpeed/6)*3 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterSpeed/6)*4 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterSpeed/6)*5 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterSpeed/6)*6 target: self selector:@selector(letterSpace) userInfo: nil repeats:NO];
}

-(void)letterSpace
{
	_brushVertex1.frame = CGRectMake(0, 0, 0, 0);
	_brushVertex2.frame = CGRectMake(0, 0, 0, 0);
	_brushVertex3.frame = CGRectMake(0, 0, 0, 0);
}

-(void)letterSegment :(NSTimer*)timer
{
	NSString * letter = [timer userInfo];
	
	currentSegment += 1;
	
	if(currentSegment>5) {
		currentSegment = 1;
		currentIndex += 1;
	}
		
	UIColor * colorTarget = [UIColor whiteColor];
	if( letterColor == 2 ){ colorTarget = [UIColor colorWithRed:0 green:1 blue:0.75 alpha:1]; }
	if( letterColor == 1 ){ colorTarget = [UIColor colorWithRed:1 green:0 blue:0 alpha:1]; }
	if( letterColor == 0 ){ colorTarget = [UIColor redColor]; }
	
	_brushVertex1.backgroundColor = colorTarget;
	_brushVertex2.backgroundColor = colorTarget;
	_brushVertex3.backgroundColor = colorTarget;
	
	_brushVertex1.frame = [self renderLetterShape:letter:currentSegment:1];
	_brushVertex2.frame = [self renderLetterShape:letter:currentSegment:2];
	_brushVertex3.frame = [self renderLetterShape:letter:currentSegment:3];
	
}



-(CGRect)renderLetterShape :(NSString*)letter :(int)segment :(int)vertex
{
	CGRect pos1 = CGRectMake(0, 0, letterWidth, letterWidth);
	CGRect pos2 = CGRectMake(0, (_brushWrapper.frame.size.height/2)-(letterWidth/2), letterWidth, letterWidth);
	CGRect pos3 = CGRectMake(0, (_brushWrapper.frame.size.height)-(letterWidth), letterWidth, letterWidth);
	
	CGRect barNull = CGRectMake(0, 0, 0, 0);
	CGRect barFull = CGRectMake(0, 0, letterWidth, _brushWrapper.frame.size.height);
	CGRect barTop = CGRectMake(0, 0, letterWidth,(_brushWrapper.frame.size.height/2)-(letterWidth/2) );
	
	CGRect barTop1 = CGRectMake(0, 0, letterWidth,(_brushWrapper.frame.size.height/4)-(letterWidth/2) );
	CGRect barTop2 = CGRectMake(0, (_brushWrapper.frame.size.height/4)-(letterWidth/2), letterWidth,(_brushWrapper.frame.size.height/4)-(letterWidth/2) );
	
	CGRect barBottom = CGRectMake(0, (_brushWrapper.frame.size.height/2)-(letterWidth/2), letterWidth,(_brushWrapper.frame.size.height/2)-(letterWidth/2) );
	CGRect barBottom1 = CGRectMake(0, (_brushWrapper.frame.size.height/2)-(letterWidth/2), letterWidth,(_brushWrapper.frame.size.height/4)-(letterWidth/2) );
	CGRect barBottom2 = CGRectMake(0, ((_brushWrapper.frame.size.height/4)*3)-(letterWidth/2), letterWidth,(_brushWrapper.frame.size.height/4)-(letterWidth/2) );
	
	
	if([letter isEqualToString:@"a"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
	}
	if([letter isEqualToString:@"b"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barBottom; }
		}
	}
	if([letter isEqualToString:@"c"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
	}
	if([letter isEqualToString:@"d"]){
		if(segment == 1){
			if(vertex == 1){ return barBottom; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barFull; }
		}
	}
	if([letter isEqualToString:@"e"]){
		if(segment == 1){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barFull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
	}
	if([letter isEqualToString:@"f"]){
		if(segment == 1){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barFull; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"g"]){
		if(segment == 1){
			if(vertex == 1){ return barTop; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barFull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"h"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom; }
		}
	}
	if([letter isEqualToString:@"i"]){
		if(segment == 3){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barFull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"j"]){
		if(segment == 1){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"k"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 3){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 4){
			if(vertex == 1){ return barTop2; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barBottom1; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barTop1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom2; }
		}
	}
	if([letter isEqualToString:@"l"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
	}
	if([letter isEqualToString:@"m"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 3){
			if(vertex == 1){ return barTop; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"n"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"o"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"p"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barTop1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"q"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 3){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom2; }
		}
		else if(segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"r"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 3){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom1; }
		}
		else if(segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barTop; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barBottom2; }
		}
	}
	if([letter isEqualToString:@"s"]){
		if(segment == 1){
			if(vertex == 1){ return barTop; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barTop1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom; }
		}
	}
	if([letter isEqualToString:@"t"]){
		if(segment == 1){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 3){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barFull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else{
			return barNull;
		}
	}
	if([letter isEqualToString:@"v"]){
		if(segment == 1){
			if(vertex == 1){ return barTop; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barBottom1; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 3){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom2; }
		}
		else if(segment == 4){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barBottom1; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barTop; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"w"]){
		if(segment == 1){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 3){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barBottom; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 4){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barFull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"x"]){
		if(segment == 1){
			if(vertex == 1){ return barTop1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom2; }
		}
		else if(segment == 2){
			if(vertex == 1){ return barTop2; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom1; }
		}
		else if(segment == 3){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 4){
			if(vertex == 1){ return barTop2; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom1; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barTop1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom2; }
		}
	}
	if([letter isEqualToString:@"y"]){
		if(segment == 1){
			if(vertex == 1){ return barTop1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 2){
			if(vertex == 1){ return barTop2; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 3){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom; }
		}
		else if(segment == 4){
			if(vertex == 1){ return barTop2; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barTop1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@"z"]){
		if(segment == 1){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barBottom; }
		}
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return pos2; }
			if(vertex == 3){ return pos3; }
		}
		else if(segment == 5){
			if(vertex == 1){ return barTop; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
		}
	}
	if([letter isEqualToString:@" "]){
		return barNull;
	}
	if([letter isEqualToString:@"-"]){
		if(vertex == 1){ return pos1; }
		if(vertex == 2){ return pos2; }
		if(vertex == 3){ return pos3; }
	}
	
	return barNull;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
	NSLog(@"Text field did begin editing");
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField
{
	NSLog(@"Text field ended editing");
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[self renderText:[textField text]];
	[self hideInterface];
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)toggleInterface:(id)sender
{
	
	[_textInput	resignFirstResponder];
	if( _interfaceWrapper.hidden == YES ){
		[self showInterface];
	}
	else{
		[self hideInterface];		
	}
}

-(void)showInterface
{
	_interfaceWrapper.hidden = NO;
	_optionLineColor.hidden = NO;
	_optionLineSpeed.hidden = NO;
	_optionLineStyle.hidden = NO;
	_optionLineWidth.hidden = NO;
	_optionText.hidden = NO;
}

-(void)hideInterface
{
	_interfaceWrapper.hidden = YES;
	_optionLineColor.hidden = YES;
	_optionLineSpeed.hidden = YES;
	_optionLineStyle.hidden = YES;
	_optionLineWidth.hidden = YES;
	_optionText.hidden = YES;
}

- (IBAction)toggleLineWidth:(id)sender
{
	if( letterWidth == tileSize/2 ){
		NSLog(@"LINE | Thin");
		letterWidth = tileSize/4;
	}
	else{
		NSLog(@"LINE | Thick");
		letterWidth = tileSize/2;
	}
	[self templateStart];
}

- (IBAction)toggleLineStyle:(id)sender
{
	if( letterRounded == 1 ){
		NSLog(@"LINE | Square");
		letterRounded = 0;
	}
	else{
		NSLog(@"LINE | Rounded");
		letterRounded = 1;
	}
	[self templateStart];
}

- (IBAction)toggleLineSpeed:(id)sender
{
	if( letterSpeed == 1 ){
		NSLog(@"LINE | Fast");
		letterSpeed = 0.5;
	}
	else{
		NSLog(@"LINE | Slow");
		letterSpeed = 1;
	}
	[self templateStart];
}

- (IBAction)toggleLineColor:(id)sender
{
	
	if( letterColor > 2 ){
		letterColor = 0;
	}
	letterColor += 1;
	[self templateStart];
}

@end
