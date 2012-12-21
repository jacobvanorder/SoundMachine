//
//  SGPUSoundMachine.h
//  PowerUp
//
//  Created by mrJacob on 12/3/12.
//  Copyright (c) 2012 sushiGrass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGSoundMachine : NSObject

+(SGSoundMachine *) soundMachine;

@property (nonatomic, assign) BOOL soundIsOff;

-(void)playSoundWithName:(NSString *)soundName;

@end
