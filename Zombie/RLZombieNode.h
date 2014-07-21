//
//  RLZombieNode.h
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface RLZombieNode : SKSpriteNode

+ (instancetype)zombieAtPosition:(CGPoint)position;

- (void) performTap;

@end
