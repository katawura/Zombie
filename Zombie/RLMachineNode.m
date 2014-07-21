//
//  RLMachineNode.m
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import "RLMachineNode.h"
#import "RLUtil.h"

@implementation RLMachineNode

+(instancetype)machineAtPosition:(CGPoint)position {
    RLMachineNode *machine = [self spriteNodeWithImageNamed:@"machine_1"];
    machine.position = position;
    machine.name = @"Machine";
    machine.anchorPoint = CGPointMake(0, 0);
    machine.zPosition = 8;
    [machine setupPhysicsBody];
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"machine_1"], [SKTexture textureWithImageNamed:@"machine_2"]];
    
    SKAction *machineAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    //this tells you how long the action above is repeated
    SKAction *machineRepeat = [SKAction repeatActionForever:machineAnimation];
    [machine runAction:machineRepeat]; //the runs the action
    [machine setupPhysicsBody];
    
    return machine;
}
- (void) setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = RLCollisionCategoryMachine;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = RLCollisionCategoryEnemy;
    
}





@end
