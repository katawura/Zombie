//
//  RLDogNode.m
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import "RLDogNode.h"
#import "RLUtil.h"

@implementation RLDogNode

+ (instancetype) dogOfType:(RLDogType)type {
    RLDogNode *dog;
    dog.damaged = NO;
    NSArray *textures;
    
    if (type == RLDogTypeA) {
        dog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_2"]];
        dog.type = RLDogTypeA;
    } else {
        dog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_3"]];
        dog.type = RLDogTypeB;
    }
    
    float scale = [RLUtil randomWithMin:150 max:200] / 100.0f;
    dog.xScale = scale;
    dog.xScale = scale;
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    [dog runAction:[SKAction repeatActionForever:animation] withKey:@"animation"];
    [dog setupPhysicsBody];
    
    return dog;
}

- (BOOL) isDamaged {
    NSArray *textures;
    
    if ( !_damaged) {
        [self removeActionForKey:@"animation"];
        
        if ( self.type == RLDogTypeA ) {
            textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_3"]];
        } else {
            textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_4"]];
        }
        
                         SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
                         [self runAction:[SKAction repeatActionForever:animation] withKey:@"damaged_animation"];
                         
                         _damaged = YES;
                         
                         return NO;
                         }
    return _damaged;
}

- (void) setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = RLCollisionCategoryEnemy;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = RLCollisionCategoryProjectile | RLCollisionCategoryMachine; //0010|1000=1010

}



@end
