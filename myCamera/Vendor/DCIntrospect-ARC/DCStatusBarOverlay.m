//
//  DCStatusBarOverlay.m
//
//  Copyright 2011 Domestic Cat. All rights reserved.
//

#import "DCStatusBarOverlay.h"

@implementation DCStatusBarOverlay

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark Setup

- (id)init
{
    if ((self = [super initWithFrame:CGRectZero]))
	{
		self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
		CGFloat screenWidthCamera = [UIScreen mainScreen].bounds.size.width;
		CGFloat screenHeightCamera = [UIScreen mainScreen].bounds.size.height;
		const CGFloat bar_size = 20;
		if (UIInterfaceOrientationIsLandscape(orientation))
			self.frame = CGRectMake(0, 0, screenHeightCamera, bar_size);
		else
			self.frame = CGRectMake(0, 0, screenWidthCamera, bar_size);
		self.backgroundColor = [UIColor blackColor];

        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundImageView.image = [[UIImage imageNamed:@"statusBarBackground.png"] stretchableImageWithLeftCapWidth:2.0f topCapHeight:0.0f];
        [self addSubview:backgroundImageView];

		self.leftLabel = [[UILabel alloc] initWithFrame:CGRectOffset(self.frame, 2.0f, 0.0f)];
		self.leftLabel.backgroundColor = [UIColor clearColor];
		self.leftLabel.textAlignment = NSTextAlignmentLeft;
		self.leftLabel.font = [UIFont boldSystemFontOfSize:12.0f];
		self.leftLabel.textColor = [UIColor colorWithWhite:0.97f alpha:1.0f];
		self.leftLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self addSubview:self.leftLabel];

		self.rightLabel = [[UILabel alloc] initWithFrame:CGRectOffset(self.frame, -2.0f, 0.0f)];
		self.rightLabel.backgroundColor = [UIColor clearColor];
		self.rightLabel.font = [UIFont boldSystemFontOfSize:12.0f];
		self.rightLabel.textAlignment = NSTextAlignmentRight;
		self.rightLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		self.rightLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self addSubview:self.rightLabel];

		UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
		[self addGestureRecognizer:gestureRecognizer];

		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBarFrame) name:UIDeviceOrientationDidChangeNotification object:nil];
	}

	return self;
}

- (void)updateBarFrame
{
	// current interface orientation
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	CGFloat screenWidthCamera = [UIScreen mainScreen].bounds.size.width;
	CGFloat screenHeightCamera = [UIScreen mainScreen].bounds.size.height;

	CGFloat pi = (CGFloat)M_PI;
	if (orientation == UIDeviceOrientationPortrait)
	{
		self.transform = CGAffineTransformIdentity;
		self.frame = CGRectMake(0, 0, screenWidthCamera, self.frame.size.height);
	}
	else if (orientation == UIDeviceOrientationLandscapeLeft)
	{
		self.transform = CGAffineTransformMakeRotation(pi * (90) / 180.0f);
		self.frame = CGRectMake(screenWidthCamera - self.frame.size.width, 0, self.frame.size.width, screenHeightCamera);
	}
	else if (orientation == UIDeviceOrientationLandscapeRight)
	{
		self.transform = CGAffineTransformMakeRotation(pi * (-90) / 180.0f);
		self.frame = CGRectMake(0, 0, self.frame.size.width, screenHeightCamera);
	}
	else if (orientation == UIDeviceOrientationPortraitUpsideDown)
	{
		self.transform = CGAffineTransformMakeRotation(pi);
		self.frame = CGRectMake(0, screenHeightCamera - self.frame.size.height, screenWidthCamera, self.frame.size.height);
	}
}

#pragma mark Actions

- (void)tapped
{
	[[NSNotificationCenter defaultCenter] postNotificationName:kDCIntrospectNotificationStatusBarTapped object:nil];
}

@end
