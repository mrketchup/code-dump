//
//  CanvasView.m
//  DrawingGame
//
//  Created by Matt Jones on 1/31/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import "CanvasView.h"

@interface CanvasView()
@property (weak, nonatomic, readonly) UIColor *strokeColor;
@property (nonatomic, readonly) CGFloat strokeThickness;
@property (nonatomic) CGPoint lastPoint;
@end


@implementation CanvasView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Maybe something will happen here someday...
    }
    return self;
}

- (UIColor *)strokeColor {
    SEL selector = @selector(strokeColorForCanvasView:);
    if ([self.delegate respondsToSelector:selector]) {
        return [self.delegate strokeColorForCanvasView:self];
    } else {
        return [UIColor blackColor];
    }
}

- (CGFloat)strokeThickness {
    SEL selector = @selector(strokeThicknessForCanvasView:);
    if ([self.delegate respondsToSelector:selector]) {
        return [self.delegate strokeThicknessForCanvasView:self];
    } else {
        return 5.0;
    }
}

- (void)layoutSubviews {
    if (!self.imageView || !self.overlayImageView) {
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        CGRect frame = CGRectMake(0, 0, w, h);
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.imageView];
        
        self.overlayImageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.overlayImageView];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.overlayImageView];
    [self drawLineOnOverlayImageFromPoint:self.lastPoint
                                  toPoint:self.lastPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.overlayImageView];
    [self drawLineOnOverlayImageFromPoint:self.lastPoint toPoint:currentPoint];
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {    
    [self mergeImages];
    
    SEL selector = @selector(canvasView:imageChangedTo:);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate canvasView:self imageChangedTo:self.imageView.image];
    }
}

- (void)drawLineOnOverlayImageFromPoint:(CGPoint)fromPoint
                                toPoint:(CGPoint)toPoint {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 1.0;
    [self.strokeColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    UIImageView *view = self.overlayImageView;
    UIGraphicsBeginImageContext(view.frame.size);
    [view.image drawInRect:CGRectMake(0, 0,
                                      view.frame.size.width,
                                      view.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.strokeThickness);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(),
                               red, green, blue, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),
                         fromPoint.x, fromPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),
                            toPoint.x, toPoint.y);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    CGContextFlush(UIGraphicsGetCurrentContext());
    view.image = UIGraphicsGetImageFromCurrentImageContext();
    [view setAlpha:alpha];
    UIGraphicsEndImageContext();
}

- (void)mergeImages {
    CGFloat alpha = 1.0;
    [self.strokeColor getRed:nil green:nil blue:nil alpha:&alpha];
    
    UIImageView *main = self.imageView;
    UIImageView *temp = self.overlayImageView;
    UIGraphicsBeginImageContext(main.frame.size);
    [main.image drawInRect:CGRectMake(0, 0,
                                      main.frame.size.width,
                                      main.frame.size.height)
                 blendMode:kCGBlendModeNormal
                     alpha:1.0];
    [temp.image drawInRect:CGRectMake(0, 0,
                                      temp.frame.size.width,
                                      temp.frame.size.height)
                 blendMode:kCGBlendModeNormal
                     alpha:alpha];
    main.image = UIGraphicsGetImageFromCurrentImageContext();
    temp.image = nil;
    UIGraphicsEndImageContext();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
