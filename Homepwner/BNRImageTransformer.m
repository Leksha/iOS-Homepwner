//
//  BNRImageTransformer.m
//  Homepwner
//
//  Created by Leksha Ramdenee on 2016-11-08.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "BNRImageTransformer.h"

@implementation BNRImageTransformer

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value {
    return [UIImage imageWithData:value];
}


@end
