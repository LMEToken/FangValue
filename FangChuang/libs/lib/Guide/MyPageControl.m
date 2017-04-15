//
//  MyPageControl.m
//  NewPageControl
//
//  Created by Miaohz on 11-8-31.
//  Copyright 2011 Etop. All rights reserved.
//

#import "MyPageControl.h"

@interface MyPageControl(private)

- (void) updateDots;

@end


@implementation MyPageControl

@synthesize imagePageStateNormal,imagePageStateHightlighted;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void) setImagePageStateNormal:(UIImage *)image
{
	imagePageStateNormal = image;
	[self updateDots];
}

- (void) setImagePageStateHighlighted:(UIImage *)image
{
	imagePageStateHightlighted = image;
	[self updateDots];
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[super endTrackingWithTouch:touch withEvent:event];
	[self updateDots];
}

- (void) updateDots
{
	if (imagePageStateNormal || imagePageStateHightlighted) {
		NSArray *subView = self.subviews;
		
		for (int i = 0; i < [subView count]; i++) {
			UIImageView *dot = [subView objectAtIndex:i];
			dot.image = (self.currentPage == i ? imagePageStateHightlighted : imagePageStateNormal);
		}
	}
}



@end
