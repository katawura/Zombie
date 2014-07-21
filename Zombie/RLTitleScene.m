//
//  RLTitleScene.m
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import "RLTitleScene.h"
#import "RLGamePlayScene.h"
#import <AVFoundation/AVFoundation.h>

@interface RLTitleScene ()
@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundmusic;
@end

@implementation RLTitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];
        
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];
        
        self.backgroundmusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundmusic.numberOfLoops = -1;
        [self.backgroundmusic prepareToPlay];
        
            }
    return self;
}

- (void) didMoveToView:(SKView *)view {
    [self.backgroundmusic play];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:self.pressStartSFX];
    [self.backgroundmusic stop];
    RLGamePlayScene *gamePlayScene = [RLGamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition doorwayWithDuration:1.0];
    [self.view presentScene:gamePlayScene transition:transition];
    
}


@end
