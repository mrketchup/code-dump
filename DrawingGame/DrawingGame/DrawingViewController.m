//
//  DrawingViewController.m
//  DrawingGame
//
//  Created by Matt Jones on 1/28/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import "DrawingViewController.h"
#import "CanvasView.h"
#import "SaveManager.h"

@interface DrawingViewController() <CanvasViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet CanvasView *canvas;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) UIColor *strokeColor;
@property (nonatomic) CGFloat strokeThickness;
@end


@implementation DrawingViewController

- (UIImage *)image {
    return self.canvas.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.canvas.imageView.image = image;
}

- (NSString *)caption {
    return self.captionLabel.text;
}

- (void)setCaption:(NSString *)caption {
    self.captionLabel.text = caption;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canvas.delegate = self;
    
    CGFloat red = (float)arc4random() / 0x100000000;
    CGFloat green = (float)arc4random() / 0x100000000;
    CGFloat blue = (float)arc4random() / 0x100000000;
    CGFloat alpha = (float)arc4random() / 0x100000000;
    self.strokeColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    self.strokeThickness = (float)arc4random() / 0x100000000 * 50 + 1;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.canvas.imageView.image = [SaveManager loadSavedImageForGame:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(UIBarButtonItem *)sender {
    UIAlertView *confirm =
    [[UIAlertView alloc] initWithTitle:@"Submit"
                               message:@"Are your sure?"
                              delegate:self
                     cancelButtonTitle:@"No"
                     otherButtonTitles:@"Yes", nil];
    [confirm show];
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)index {
    if (index == 1) {
        self.canvas.imageView.image = nil;
    }
}

- (void)canvasView:(CanvasView *)canvas imageChangedTo:(UIImage *)image {
    [SaveManager saveImage:image forGame:nil];
    
    CGFloat red = (float)arc4random() / 0x100000000;
    CGFloat green = (float)arc4random() / 0x100000000;
    CGFloat blue = (float)arc4random() / 0x100000000;
    CGFloat alpha = (float)arc4random() / 0x100000000;
    self.strokeColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    self.strokeThickness = (float)arc4random() / 0x100000000 * 25 + 1;
}

- (UIColor *)strokeColorForCanvasView:(CanvasView *)canvas {
    return self.strokeColor;
}

- (CGFloat)strokeThicknessForCanvasView:(CanvasView *)canvas {
    return self.strokeThickness;
}

@end
