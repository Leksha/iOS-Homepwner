//
//  BNRItemCell.m
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-10-31.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "BNRItemCell.h"

@interface BNRItemCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;

@end

@implementation BNRItemCell

#pragma mark Dynamic Type

- (void)updateInterfaceForDynamicTypeSize {
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    
    // Programatically set the imageView size
    static NSDictionary *imageSizeDictionary;
    
    if (!imageSizeDictionary){
        imageSizeDictionary = @ { UIContentSizeCategoryExtraSmall : @40,
                                  UIContentSizeCategorySmall      : @40,
                                  UIContentSizeCategoryMedium     : @40,
                                  UIContentSizeCategoryLarge      : @40,
                                  UIContentSizeCategoryExtraLarge : @45,
                                  UIContentSizeCategoryExtraExtraLarge :@55,
                                  UIContentSizeCategoryExtraExtraExtraLarge : @65 };
    }
    
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *imageSize = imageSizeDictionary[userSize];
    self.imageViewHeightConstraint.constant = imageSize.floatValue;
    self.imageViewWidthConstraint.constant = imageSize.floatValue;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self updateInterfaceForDynamicTypeSize];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(updateInterfaceForDynamicTypeSize)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
}

- (void)dealloc {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}

- (void)updateValueLabelColor {
    BOOL isValueGreaterThan50 = ([[self.valueLabel.text substringFromIndex:1] doubleValue] > 50.0);
    if (isValueGreaterThan50) {
        self.valueLabel.textColor = [UIColor greenColor];
    } else {
        self.valueLabel.textColor = [UIColor redColor];
    }
}
@end
