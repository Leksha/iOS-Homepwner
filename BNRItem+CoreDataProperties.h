//
//  BNRItem+CoreDataProperties.h
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-11-09.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "BNRItem+CoreDataClass.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem (CoreDataProperties)

+ (NSFetchRequest<BNRItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dateCreated;
@property (nullable, nonatomic, copy) NSString *itemKey;
@property (nullable, nonatomic, copy) NSString *itemName;
@property (nonatomic) double orderingValue;
@property (nullable, nonatomic, copy) NSString *serialNumber;
@property (nullable, nonatomic, retain) UIImage *thumbnail;
@property (nonatomic) int valueInDollars;
@property (nullable, nonatomic, retain) NSManagedObject *assetType;


- (void)setThumbnailForImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
