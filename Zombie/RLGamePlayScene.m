//
//  RLGamePlayScene.m
//  Zombie
//
//  Created by Kelvin Atawura on 18/07/2014.
//  Copyright (c) 2014 Recodedlabs. All rights reserved.
//

#import "RLGamePlayScene.h"
#import "RLMachineNode.h"
#import "RLZombieNode.h"
#import "RLProjectileNode.h"
#import "RLDogNode.h"
#import "RLGroundNode.h"
#import "RLUtil.h"
#import <AVFoundation/AVFoundation.h>
#import "RLHudNode.h"
#import "RLGameOverNode.h"

@interface RLGamePlayScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;
@property (nonatomic) AVAudioPlayer *backgroundmusic;
@property (nonatomic) AVAudioPlayer *gameOverMusic;
@property (nonatomic) BOOL gameOver;
@property (nonatomic) BOOL restart;
@property (nonatomic) BOOL gameOverDisplayed;

@end

@implementation RLGamePlayScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.lastUpdateTimeInterval = 0;
        self.timeSinceEnemyAdded = 0;
        self.addEnemyTimeInterval = 1.5;
        self.totalGameTime = 0;
        self.minSpeed = RLDogMinSpeed;
        self.restart = NO;
        self.gameOver = NO;
        self.gameOverDisplayed = NO;
        
        /* Setup your scene here */
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        RLMachineNode *machine = [RLMachineNode machineAtPosition:CGPointMake(12, 12)];
        [self addChild:machine];
        
        RLZombieNode *zombie = [RLZombieNode zombieAtPosition:CGPointMake(20, 12)];
        [self addChild:zombie];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        RLGroundNode *ground = [RLGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
        [self addChild:ground];
        
        [self setUpSounds];
        
        RLHudNode *hud = [RLHudNode hudAtPosition:CGPointMake(0, self.frame.size.height-20) inFrame:self.frame];
        [self addChild:hud];
        
        
    }
    return self;
}

- (void) didMoveToView:(SKView *)view {
    [self.backgroundmusic play];
    
}

- (void) setUpSounds {
    self.damageSFX = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:NO];
    self.laserSFX = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:NO];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
    
    self.backgroundmusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.backgroundmusic.numberOfLoops = -1;
    [self.backgroundmusic prepareToPlay];
    
    NSURL * gameOverurl = [[NSBundle mainBundle] URLForResource:@"GameOver" withExtension:@"mp3"];
    
    self.gameOverMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:gameOverurl error:nil];
    self.gameOverMusic.numberOfLoops = 1;
    [self.gameOverMusic prepareToPlay];

}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.gameOver) {
        for (UITouch *touch in touches) {
            CGPoint positon = [touch locationInNode:self];
            [self shootProjectileTowardsPosition:positon];
        }
    } else if (self.restart){
        
        for (SKNode *node in [self children]) {
            [node removeFromParent];
        }
        RLGamePlayScene *scene = [RLGamePlayScene sceneWithSize:self.view.bounds.size];
        [self.view presentScene:scene];
    }
    
    
    
}

- (void) performGameOver {
    RLGameOverNode *gameOver = [RLGameOverNode gameOverAtPosition:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame))];
    [self addChild:gameOver];
    self.restart = YES;
    self.gameOverDisplayed = YES;
    [gameOver performAnimation];
    [self.backgroundmusic stop];
    [self.gameOverMusic play];
}

- (void) shootProjectileTowardsPosition:(CGPoint)positon {
    RLZombieNode *zombie = (RLZombieNode*)[self childNodeWithName:@"zombie"];
    [zombie performTap];
    
    RLMachineNode *machine = (RLMachineNode *)[self childNodeWithName:@"Machine"];
    
    RLProjectileNode *projectile = [RLProjectileNode projectileAtPosition:CGPointMake(machine.position.x+30, machine.position.y+60)];
    [self addChild:projectile];
    [projectile moveTowardsPosition:positon];
    
    [self runAction:self.laserSFX];
}


- (void) addDog {
    //RLDogNode *dogA = [RLDogNode dogOfType:RLDogTypeA];
    //dogA.position = CGPointMake(500,50 );
    //[self addChild:dogA];

    //RLDogNode *dogB = [RLDogNode dogOfType:RLDogTypeB];
    //dogB.position = CGPointMake(450, 50);
    //[self addChild:dogB];
    
    NSUInteger randomDog = [RLUtil randomWithMin:0 max:2];
   
    RLDogNode *dog = [ RLDogNode dogOfType:randomDog];
     float dy = [RLUtil randomWithMin:RLDogMinSpeed max:RLDogMaxSpeed];
    dog.physicsBody.velocity = CGVectorMake(dy, 0);
    
    float y = [RLUtil randomWithMin:10+dog.size.height max:self.frame.size.height-dog.size.width-10];
    float x= self.frame.size.width + dog.size.width;
    
    dog.position = CGPointMake(x, y);
    [self addChild:dog];
    
    
}

- (void) update:(NSTimeInterval)currentTime {
    if (self.lastUpdateTimeInterval) {
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval && !self.gameOver) {
        [self addDog];
        self.timeSinceEnemyAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if ( self.totalGameTime > 480) {
        // 480/60=8 minutes
        self.addEnemyTimeInterval = 0.5;
        self.minSpeed = -160;
        
    } else if ( self.totalGameTime > 240) {
        // 240/60=4 minutes
        self.addEnemyTimeInterval = 0.65;
        self.minSpeed = -150;
    } else if ( self.totalGameTime > 120) {
        // 120/60= 2minutes
        self.addEnemyTimeInterval = 0.75;
        self.minSpeed = -125;
    } else if ( self.totalGameTime > 30) {
        // 30minutes
        self.addEnemyTimeInterval = 1.00;
        self.minSpeed = -100;
        
    }
    
    if (self.gameOver && !self.gameOverDisplayed) {
        [self performGameOver];
    }
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ( firstBody.categoryBitMask == RLCollisionCategoryEnemy && secondBody.categoryBitMask == RLCollisionCategoryProjectile ) {
     
        RLDogNode *dog = (RLDogNode *)firstBody.node;
        RLProjectileNode *projectile = (RLProjectileNode *)secondBody.node;
        
        if ( [ dog isDamaged]) {
            [self runAction:self.explodeSFX];
            
            [dog removeFromParent];
            [projectile removeFromParent];
            [self createDebrisAtPosition:contact.contactPoint];
            [self addPoints: RLPointsPerHit];
        }
        
        
        
    } else if (firstBody.categoryBitMask == RLCollisionCategoryEnemy && secondBody.categoryBitMask == RLCollisionCategoryMachine) {
        
        [self runAction:self.damageSFX];
        
        RLDogNode *dog = (RLDogNode*)firstBody.node;
        [dog removeFromParent];
         [self createDebrisAtPosition:contact.contactPoint];
        
        
        [self loseLife];
    }
    
    
}

- (void) addPoints: (NSInteger)points{
    RLHudNode *hud = (RLHudNode*)[self childNodeWithName:@"HUD"];
    [hud addPoints:points];
}

- (void) loseLife {
    RLHudNode *hud = (RLHudNode*)[self childNodeWithName:@"HUD"];
    self.gameOver = [hud loseLife];
}

- (void) createDebrisAtPosition:(CGPoint)position {
    NSInteger numberOfPieces = [RLUtil randomWithMin:5 max:20];
    
    for (int i=0; i < numberOfPieces; i++) {
        NSInteger randomPieces = [RLUtil randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%d", randomPieces];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = RLCollisionCategoryDebris;
        debris.physicsBody.categoryBitMask = 0;
        debris.physicsBody.collisionBitMask = RLCollisionCategoryGround | RLCollisionCategoryEnemy;
        debris.name = @"Debris";
        
        debris.physicsBody.velocity = CGVectorMake([RLUtil randomWithMin:-150 max:150], [RLUtil randomWithMin:150 max:350]);
        
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
    }
    
    NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
    SKEmitterNode *explosion = [ NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    explosion.position = position;
    [self addChild:explosion];
    
    [explosion runAction:[SKAction waitForDuration:2.0] completion:^{
        [explosion removeFromParent];
    }];
    
}


@end
