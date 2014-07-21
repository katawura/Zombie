//
//  RLProjectileNode.m
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import "RLProjectileNode.h"
#import "RLUtil.h"
@implementation RLProjectileNode

+(instancetype)projectileAtPosition:(CGPoint)position {
    RLProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position = position;
    projectile.name = @"Projectile";
    
    [projectile setUpAnimation];
    
    [projectile setupPhysicsBody];
    
    return projectile;
    
}

- (void) setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = RLCollisionCategoryProjectile;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = RLCollisionCategoryEnemy;
    
}

- (void) setUpAnimation {
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"projectile_1"], [SKTexture textureWithImageNamed:@"projectile_2"],
                          [SKTexture textureWithImageNamed:@"projectile_3"]];

    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];

    //this tells you how long the action above is repeated
    SKAction *repeatAction = [SKAction repeatActionForever:animation];
    [self runAction:repeatAction]; //the runs the action

 
}

- (void) moveTowardsPosition:(CGPoint)position {
    // slope = (y3-y1)/(x3-x1)
    float slope = (position.y - self.position.y) / (position.x - self.position.x);
    
    //slope = (y2-y1) / (x2-x1)
    //y2 - y1 = slope (x2-x1)
    //y2 = slopes*x2 - slope*x1 + y1
    
    float offscreenX;
    
    if (position.x <= self.position.x) {
        offscreenX = -10;
    } else {
        offscreenX = self.parent.frame.size.width + 10;
    }
    
    float offscreenY = slope * offscreenX - slope * self.position.x + self.position.y;
    
    CGPoint pointOffscreen = CGPointMake(offscreenX, offscreenY);
    
    float distanceA = pointOffscreen.y - self.position.y;
    float distanceB = pointOffscreen.x - self.position.x;
    
    float distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB, 2));
    
    // distnace = speed * time
    //time = distnace / speed
    
    float time = distanceC / RLProjectileSpeed;
    float waitToFade =  time * 0.75;
    float fadeTime = time - waitToFade;
    
    SKAction *moveProjectile = [SKAction moveTo:pointOffscreen duration:time];
    [self runAction:moveProjectile];
                                
    NSArray *sequence = @[[SKAction waitForDuration:waitToFade],
                          [SKAction fadeOutWithDuration:fadeTime],
                          [SKAction removeFromParent]];
                                
    [self runAction:[SKAction sequence:sequence]];
    
    
}

@end
