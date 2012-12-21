//
//  SGViewController.m
//  SoundMachine
//
//  Created by mrJacob on 12/21/12.
//  Copyright (c) 2012 sushiGrass. All rights reserved.
//

#import "SGViewController.h"
#import "SGSoundMachine.h"

@interface SGViewController ()

@property (strong, nonatomic) IBOutlet UIButton *cowbellButton;

- (IBAction)soundButtonWasTapped:(UIButton *)sender;
- (IBAction)muteButtonWasTapped:(UIButton *)sender;

@end

@implementation SGViewController

#pragma mark delegate methods

#pragma mark customization

#pragma mark prototyping

#pragma mark stock code

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SGSoundMachine soundMachine];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)soundButtonWasTapped:(UIButton *)sender {
    
    [[SGSoundMachine soundMachine] playSoundWithName:sender.titleLabel.text];
    
}

- (IBAction)muteButtonWasTapped:(UIButton *)sender {
    if ([[SGSoundMachine soundMachine] soundIsOff] == NO) {
        [[SGSoundMachine soundMachine] setSoundIsOff:YES];
        [sender setTitle:@"Unmute" forState:UIControlStateNormal];
    }
    else {
        [[SGSoundMachine soundMachine] setSoundIsOff:NO];
        [sender setTitle:@"Mute" forState:UIControlStateNormal];
    }
}
@end
