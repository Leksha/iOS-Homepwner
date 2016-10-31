//
//  BNRItemCell.h
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-10-31.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
