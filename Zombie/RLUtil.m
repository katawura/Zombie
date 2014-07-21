//
//  RLUtil.m
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import "RLUtil.h"

@implementation RLUtil

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max {
    return arc4random()%(max - min) + min;
}
@end
