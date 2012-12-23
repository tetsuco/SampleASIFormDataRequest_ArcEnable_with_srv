//
//  ViewController.h
//  SampleASIFormDataRequest_ArcEnable
//
//  Created by  on 11/11/14.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

@interface ViewController : UIViewController {
    UIProgressView *pb;     // プログレスバー
    UISwitch *sw;           // スイッチ
}

- (void)uplaodDataButtonAction:(UIButton*)sender;
- (void)uploadStart;


@end
