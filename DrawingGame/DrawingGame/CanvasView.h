//
//  CanvasView.h
//  DrawingGame
//
//  Created by Matt Jones on 1/31/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CanvasView;

@protocol CanvasViewDelegate <NSObject>

@optional
- (UIColor *)strokeColorForCanvasView:(CanvasView *)canvas;
- (CGFloat)strokeThicknessForCanvasView:(CanvasView *)canvas;
- (void)canvasView:(CanvasView *)canvas imageChangedTo:(UIImage *)image;

@end

@interface CanvasView : UIView

@property (weak, nonatomic) id<CanvasViewDelegate> delegate;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *overlayImageView;

@end
