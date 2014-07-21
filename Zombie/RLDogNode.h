//
//  RLDogNode.h
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, RLDogType) {
    RLDogTypeA = 0,
    RLDogTypeB = 1
};

@interface RLDogNode : SKSpriteNode

@property (nonatomic, getter = isDamaged) BOOL damaged;
@property (nonatomic) RLDogType type;

+ (instancetype) dogOfType:(RLDogType)type;
@end
