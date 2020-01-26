//
//  CaptionViewController.m
//  DrawingGame
//
//  Created by Matt Jones on 3/22/13.
//  Copyright (c) 2013 Jones Brothers. All rights reserved.
//

#import "CaptionViewController.h"
#import "SaveManager.h"

@interface CaptionViewController () <UITextViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *caption;
@end

@implementation CaptionViewController

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.imageView.image = [SaveManager loadSavedImageForGame:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:self.view.window];
    
    [center addObserver:self
               selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:self.view.window];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification *)n {
    CGFloat kbHeight =
    [n.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self setViewMovedUp:YES withKeyboardHeight:kbHeight];
}

- (void)keyboardWillHide:(NSNotification *)n {
    CGFloat kbHeight =
    [n.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self setViewMovedUp:NO withKeyboardHeight:kbHeight];
}

- (void)setViewMovedUp:(BOOL)movedUp withKeyboardHeight:(CGFloat)height {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect viewRect = self.view.frame;
    CGRect imageRect = self.imageView.frame;
    CGRect captionRect = self.caption.frame;
    if (movedUp) {
        viewRect.size.height -= height;
        imageRect.size.height -= height;
        captionRect.size.height -= height;
    } else {
        viewRect.size.height += height;
        imageRect.size.height += height;
        captionRect.size.height += height;
    }
    
    self.view.frame = CGRectMake(viewRect.origin.x, viewRect.origin.y,
                                 viewRect.size.width, viewRect.size.height);
    self.imageView.frame = CGRectMake(imageRect.origin.x, imageRect.origin.y,
                                      imageRect.size.width, imageRect.size.height);
    self.caption.frame = CGRectMake(captionRect.origin.x, captionRect.origin.y,
                                    captionRect.size.width, captionRect.size.height);
    [UIView commitAnimations];
}

- (BOOL)       textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
        replacementText:(NSString*)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    NSString *result = [textView.text stringByReplacingCharactersInRange:range
                                                              withString:text];
    self.navigationItem.rightBarButtonItem.enabled = ![result isEqualToString:@""];
    return result.length <= 140;
}

- (IBAction)submit:(UIBarButtonItem *)sender {
    [self.caption resignFirstResponder];
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
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.caption.text = @"";
    }
}

@end
