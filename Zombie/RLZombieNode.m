//
//  RLZombieNode.m
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import "RLZombieNode.h"

@interface RLZombieNode ()
@property (nonatomic) SKAction *tapAction;
@end

@implementation RLZombieNode

+(instancetype)zombieAtPosition:(CGPoint)position {
    RLZombieNode *zombie = [self spriteNodeWithImageNamed:@"spacecat_1"];
    zombie.position = position;
    zombie.anchorPoint = CGPointMake(0, 0);
    zombie.name = @"zombie";
    zombie.zPosition = 9;
    
    //NSArray *textures = @[[SKTexture textureWithImageNamed:@"spacecat_1"], [SKTexture textureWithImageNamed:@"spacecat_2"]];
    
    //SKAction *zombieAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    //this tells you how long the action above is repeated
    //SKAction *zombieRepeat = [SKAction repeatActionForever:zombieAnimation];
    //[zombie runAction:zombieRepeat]; //the runs the action and makes spacecat animate without a tap.
    
    return zombie;
}

- (void) performTap {
    [self runAction:self.tapAction];
}

- (SKAction *) tapAction{
    if (_tapAction != nil) {
        return _tapAction;
    }
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"spacecat_2"], [SKTexture textureWithImageNamed:@"spacecat_1"]];
    _tapAction = [SKAction animateWithTextures:textures timePerFrame:0.25];
    
    return _tapAction;

}


@end
