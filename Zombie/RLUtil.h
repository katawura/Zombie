//
//  RLUtil.h
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int RLProjectileSpeed = 400;
static const int RLDogMinSpeed = -100;
static const int RLDogMaxSpeed = -50;
static const int RLMaxLives = 4;
static const int RLPointsPerHit = 100;

typedef NS_OPTIONS(uint32_t, RLCollisionCategory) {
    RLCollisionCategoryEnemy        = 1 << 0,   //0000
    RLCollisionCategoryProjectile   = 1 << 1,   //0010
    RLCollisionCategoryDebris       = 1 << 2,   //0100
    RLCollisionCategoryMachine      = 1 << 3,    //1000
    RLCollisionCategoryGround       = 1 << 4
};

@interface RLUtil : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;


@end
