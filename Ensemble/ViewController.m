//
//  ViewController.m
//  Ensemble
//
//  Created by Jele on 11/8/2022.
//

#import "ViewController.h"
#import <AgoraRtcKit/AgoraRtcKit.h>
#import "Ensemble-Swift.h"

@interface ViewController ()
<EnsembleProtocol>
@property (nonatomic, strong) EnsembleViewModel *viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (IBAction)tap1:(id)sender {
    [self.viewModel prepareOne];
}

- (IBAction)tap2:(id)sender {
    [self.viewModel prepareTwo];
}
    
- (EnsembleViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[EnsembleViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

- (void)joinWithInstrument:(enum MusicalInstrument)instrument type:(enum EnsembleType)type {
    EnsembleViewController *vc = [[EnsembleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

