//
//  RLGroundNode.m
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import "RLGroundNode.h"



@implementation RLGroundNode

+ (instancetype) groundWithSize: (CGSize)size {
    RLGroundNode *ground = [self spriteNodeWithColor:[SKColor greenColor] size:size];
    ground.name = @"Ground";
    ground.position = CGPointMake(size.width/2,size.height/2);
    
    
    return ground;
}



@end
