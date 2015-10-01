//
//  ViewController.m
//  ViewAnimation
//
//  Created by Tran Tuan Hai on 10/1/15.
//  Copyright (c) 2015 Tran Tuan Hai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *heading;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIImageView *cloud1;
@property (weak, nonatomic) IBOutlet UIImageView *cloud2;
@property (weak, nonatomic) IBOutlet UIImageView *cloud3;
@property (weak, nonatomic) IBOutlet UIImageView *cloud4;

@end

@implementation ViewController {
  UIActivityIndicatorView *_spinner;
  UIImageView *_status;
  UILabel *_label;
  NSArray *_message;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Set up UI
  self.loginButton.layer.cornerRadius = 8.0f;
  self.loginButton.layer.masksToBounds = YES;
  
  _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  _spinner.frame = CGRectMake(-20.0f, 6.0f, 20.0f, 20.0f);
  [_spinner startAnimating];
  _spinner.alpha = 0.0f;
  [self.view addSubview:_spinner];
  
  _status = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
  _status.hidden = YES;
  _status.center = self.loginButton.center;
  [self.view addSubview:_status];
  
  _label = [UILabel new];
  _label.frame = CGRectMake(0.0f, 0.0f, _status.frame.size.width, _status.frame.size.height);
  _label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
  _label.textColor = [UIColor colorWithRed:0.89f green:0.38f blue:0.0f alpha:1.0f];
  _label.textAlignment = NSTextAlignmentCenter;
  [_status addSubview:_label];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  //Move form element out of screen
  [self moveOutFormElement:self.heading];
  [self moveOutFormElement:self.username];
  [self moveOutFormElement:self.password];
  
  [self fadeCloud:self.cloud1];
  [self fadeCloud:self.cloud2];
  [self fadeCloud:self.cloud3];
  [self fadeCloud:self.cloud4];
}

- (void)moveOutFormElement:(UIView*)element{
  element.center = ({
    CGPoint center = element.center;
    center.x -= self.view.bounds.size.width;
    center;
  });
}

- (void)fadeCloud:(UIView*)cloud{
  cloud.alpha = 0.0f;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  //Move form element back with animation
  [self moveBackFormElement:self.heading duration:0.5f delay:0.0f option:0];
  [self moveBackFormElement:self.username duration:0.5f delay:0.3f option:0];
  [self moveBackFormElement:self.password duration:0.5f delay:0.4f option:0];
  
  [self displayCloud:self.cloud1 duration:0.5f delay:0.5f options:0];
  [self displayCloud:self.cloud2 duration:0.5f delay:0.7f options:0];
  [self displayCloud:self.cloud3 duration:0.5f delay:0.9f options:0];
  [self displayCloud:self.cloud4 duration:0.5f delay:1.1f options:0];
}

- (void)moveBackFormElement:(UIView*)element
                   duration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                     option:(UIViewAnimationOptions)options{
  [UIView animateWithDuration:duration delay:delay options:options animations:^{
    element.center = ({
      CGPoint center = element.center;
      center.x += self.view.bounds.size.width;
      center;
    });
  } completion:^(BOOL finished) {
    
  }];
}

- (void)displayCloud:(UIView*)cloud
            duration:(NSTimeInterval)duration
               delay:(NSTimeInterval)delay
             options:(UIViewAnimationOptions)options {
  [UIView animateWithDuration:duration delay:delay options:options animations:^{
    cloud.alpha = 1.0f;
  } completion:^(BOOL finished) {
    
  }];
}

#pragma mark - Other methods

- (IBAction)login:(id)loginButton {
}

@end
