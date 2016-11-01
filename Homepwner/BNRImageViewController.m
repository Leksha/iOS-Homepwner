//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-11-01.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController () <UIScrollViewDelegate>

@end

@implementation BNRImageViewController

- (void)loadView {
    // Add a UIScrollView to enable zooming
    CGRect scrollViewFrame = CGRectMake(0, 0,
                                        self.preferredContentSize.width, self.preferredContentSize.height);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollViewFrame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:imageView];
    self.imageView = imageView;

    scrollView.minimumZoomScale = 0.4;
    scrollView.maximumZoomScale = 4.0;
    scrollView.clipsToBounds = YES;
    scrollView.delegate = self;
    
//    CGSize origImageSize = self.image.size;
//    
//    float ratio = MAX(imageView.bounds.size.width / origImageSize.width,
//                      imageView.bounds.size.height / origImageSize.height);
//    
//    // Center the image in the view
//    double width = ratio * origImageSize.width;
//    double height = ratio * origImageSize.height;
//    double xOrigin = (self.preferredContentSize.width - width) / 2.0;
//    double yOrigin = (self.preferredContentSize.height - height) / 2.0;
//    
//    CGPoint centerImageView = CGPointMake(xOrigin + width/2,
//                                          yOrigin + height/2);
//    imageView.center = centerImageView;
    self.view = scrollView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // We must cast the view to UIImageView so the compiter knows it is
    // ok to send it setImage:
    UIImageView *imageView = self.imageView;
    imageView.image = self.image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView.subviews firstObject];
}

@end
