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
	letterWidth = 0.5;
	
	[self templateStart];
//	[self animationTest];
	[self renderText:@"- leave something witchy"];
}

-(void)templateStart
{
	tileSize = self.view.frame.size.width/32;
	screenWidth = self.view.frame.size.width;
	screenHeight = self.view.frame.size.height;
	
	self.brushWrapper.frame = CGRectMake( (screenWidth/2)-(tileSize/2), tileSize, tileSize, screenHeight-(2*tileSize));
	
	_brushVertex1.layer.cornerRadius = tileSize/2;
	_brushVertex2.layer.cornerRadius = tileSize/2;
	_brushVertex3.layer.cornerRadius = tileSize/2;
}

-(void)renderText :(NSString*)text
{
	NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: letterWidth target: self selector:@selector(renderTextTrigger:) userInfo: text repeats:YES];
}

-(void)renderTextTrigger :(NSTimer *)timer
{
	NSString * text = [timer userInfo];
	NSString * targetLetter = [NSString stringWithFormat:@"%C", [text characterAtIndex:(currentIndex % [text length])] ];
	[self renderLetter:targetLetter];
}

-(void)renderLetter:(NSString *)letter
{
	[NSTimer scheduledTimerWithTimeInterval: (letterWidth/6)*1 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterWidth/6)*2 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterWidth/6)*3 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterWidth/6)*4 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterWidth/6)*5 target: self selector:@selector(letterSegment:) userInfo: letter repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval: (letterWidth/6)*6 target: self selector:@selector(letterSpace) userInfo: nil repeats:NO];
}

-(void)letterSpace
{
	NSLog(@"Letter: ");
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
	
	NSLog(@"Letter: %@ segment: %d", letter, currentSegment);
	
	if( [letter isEqualToString:@"-"] ){
		_brushVertex1.backgroundColor = [UIColor redColor];
		_brushVertex2.backgroundColor = [UIColor redColor];
		_brushVertex3.backgroundColor = [UIColor redColor];
	}
	else{
		_brushVertex1.backgroundColor = [UIColor whiteColor];
		_brushVertex2.backgroundColor = [UIColor whiteColor];
		_brushVertex3.backgroundColor = [UIColor whiteColor];
	}
	
	_brushVertex1.frame = [self renderLetterShape:letter:currentSegment:1];
	_brushVertex2.frame = [self renderLetterShape:letter:currentSegment:2];
	_brushVertex3.frame = [self renderLetterShape:letter:currentSegment:3];
	
}



-(CGRect)renderLetterShape :(NSString*)letter :(int)segment :(int)vertex
{
	NSLog(@"%@ %d",letter,segment);
	CGRect pos1 = CGRectMake(0, 0, tileSize, tileSize);
	CGRect pos2 = CGRectMake(0, (_brushWrapper.frame.size.height/2)-(tileSize/2), tileSize, tileSize);
	CGRect pos3 = CGRectMake(0, (_brushWrapper.frame.size.height)-(tileSize), tileSize, tileSize);
	
	CGRect barNull = CGRectMake(0, 0, 0, 0);
	CGRect barFull = CGRectMake(0, 0, tileSize, _brushWrapper.frame.size.height);
	CGRect barTop = CGRectMake(0, 0, tileSize,(_brushWrapper.frame.size.height/2)-(tileSize/2) );
	
	CGRect barTop1 = CGRectMake(0, 0, tileSize,(_brushWrapper.frame.size.height/4)-(tileSize/2) );
	CGRect barTop2 = CGRectMake(0, (_brushWrapper.frame.size.height/4)-(tileSize/2), tileSize,(_brushWrapper.frame.size.height/4)-(tileSize/2) );
	
	
	CGRect barBottom = CGRectMake(0, (_brushWrapper.frame.size.height/2)-(tileSize/2), tileSize,(_brushWrapper.frame.size.height/2)-(tileSize/2) );
	CGRect barBottom1 = CGRectMake(0, (_brushWrapper.frame.size.height/2)-(tileSize/2), tileSize,(_brushWrapper.frame.size.height/4)-(tileSize/2) );
	CGRect barBottom2 = CGRectMake(0, ((_brushWrapper.frame.size.height/4)*3)-(tileSize/2), tileSize,(_brushWrapper.frame.size.height/4)-(tileSize/2) );
	
	
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
		else if(segment == 2 || segment == 3 || segment == 4){
			if(vertex == 1){ return barNull; }
			if(vertex == 2){ return barFull; }
			if(vertex == 3){ return barNull; }
		}
		else if(segment == 5){
			if(vertex == 1){ return pos1; }
			if(vertex == 2){ return barNull; }
			if(vertex == 3){ return barNull; }
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

@end
