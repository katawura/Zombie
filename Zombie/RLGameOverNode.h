//
//  RLGameOverNode.h
//  Zombie
//
//  Created by Kelvin Atawura on 21/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface RLGameOverNode : SKNode

+ (instancetype) gameOverAtPosition:(CGPoint)position;

- (void) performAnimation;

@end
