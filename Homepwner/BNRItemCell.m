//
//  BNRItemCell.m
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-10-31.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
