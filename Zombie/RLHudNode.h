//
//  RLHudNode.h
//  Zombie
//
//  Created by Kelvin Atawura on 20/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface RLHudNode : SKNode

@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger score;

+ (instancetype) hudAtPosition:(CGPoint)position inFrame:(CGRect)frame;

- (void) addPoints:(NSInteger)points;
- (BOOL) loseLife;

@end
