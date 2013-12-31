//
//  SGPUSoundMachine.m
//  PowerUp
//
//  Created by mrJacob on 12/3/12.
//  Copyright (c) 2012 sushiGrass. All rights reserved.
//

#import "SGSoundMachine.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SGSoundMachine () <AVAudioPlayerDelegate>

@property (nonatomic, strong) NSDictionary *soundDictionary;

@end

@implementation SGSoundMachine

+(SGSoundMachine *)soundMachine {
    
    static SGSoundMachine *soundMachine;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        soundMachine = [SGSoundMachine new];
    });
    
    return soundMachine;
}

-(id)init {
    if (self) {
                
        NSString *newSoundPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Sounds"];
        NSError *error = nil;
        NSArray *soundFileNameArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:newSoundPath error:&error];
      
        NSMutableDictionary *temporaryDictionary = [@{} mutableCopy];
        
        for (NSString *rawFileName in soundFileNameArray) {
            NSString *fileName = [rawFileName stringByDeletingPathExtension];
            NSString* soundPath = [[NSBundle mainBundle] pathForResource:[@"Sounds/" stringByAppendingString:fileName] ofType:@"wav"];
            if (soundPath) {
                NSURL* soundURL = [NSURL fileURLWithPath:soundPath];
                
                NSNumber *soundIDNumber = _soundDictionary[fileName];
                SystemSoundID soundID = soundIDNumber.integerValue;
                
                OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundID);
                
                [temporaryDictionary addEntriesFromDictionary:@{fileName : [NSNumber numberWithInteger:soundID]}];
                
                if (err != kAudioServicesNoError) {
                    NSLog(@"Could not load %@, error code: %d", soundURL, (int)err);
                }
            }
            else {
                NSLog(@"sound path %@ not valid", fileName);
            }
        }
        
        _soundDictionary = [NSDictionary dictionaryWithDictionary:temporaryDictionary];
    }
    return self;
}

-(void)playSoundWithName:(NSString *)soundName {
    
    if ([self soundIsOff] == NO) {
        
        NSNumber *soundIDNumber = self.soundDictionary[soundName];
        if (soundIDNumber) {
            SystemSoundID soundID = soundIDNumber.integerValue;
            AudioServicesPlaySystemSound(soundID);
        }
    }
}

@end
