//
//  ViewController.m
//  SampleASIFormDataRequest_ArcEnable
//
//  Created by  on 11/11/14.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // 背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //--------------------------------------------------
    // ファイルアップロードボタン
    //--------------------------------------------------
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.frame = CGRectMake(60, 150, 200, 40);
    [bt setTitle:@"ファイルアップロード" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(uplaodDataButtonAction:)forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bt];
    
    
    //--------------------------------------------------
    // プログレスバー
    //--------------------------------------------------
    pb = [[UIProgressView alloc]
          initWithProgressViewStyle:UIProgressViewStyleDefault];
    pb.frame = CGRectMake(60, 20, 200, 10);
    pb.progress = 0.0;
    [self.view addSubview:pb];
    
    
    //--------------------------------------------------
    // ラベル
    //--------------------------------------------------
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 265, 200, 50);
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    label.textAlignment = UITextAlignmentLeft;
    label.text = @"プログレスバーを使用する";
    [self.view addSubview:label];
    
    
    //--------------------------------------------------
    // スイッチ
    //--------------------------------------------------
    sw = [[UISwitch alloc] init];
    sw.center = CGPointMake(250, 290);
    sw.on = NO;
    [self.view addSubview:sw];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - File Upload Button Action

//--------------------------------------------------
// ファイルアップロードボタンアクション
//--------------------------------------------------
- (void)uplaodDataButtonAction:(UIButton*)sender
{
    // アップロード
    [self uploadStart];
}


#pragma mark - Upload Action

//--------------------------------------------------
// アップロード処理
//--------------------------------------------------
- (void)uploadStart
{
    NSURL *url = [NSURL URLWithString:@"http://localhost/test/uploadsample.php"];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [request setPostValue:@"hoge" forKey:@"file_name"];  // ファイル名(仮名:hoge)
    [request setPostValue:@"jpg" forKey:@"extension"];  // 拡張子
    
    // データをセット
    NSString *path = [[NSBundle mainBundle] pathForResource:@"A5B8A1BCA5D7A3B1" ofType:@"jpg"];
    NSData *image = [NSData dataWithContentsOfFile:path];
    [request setData:image forKey:@"upfile"];
    
    [request setTimeOutSeconds:120];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(postSucceeded:)];
    [request setDidFailSelector:@selector(postFailed:)];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    if (sw.on == 0) {
        // プログレスバーを使用せずに非同期通信する場合に使用
        [request startAsynchronous];
        
        NSLog(@"プログレスバー未使用");
    } else {
        // プログレスバーを使用する
        ASINetworkQueue *networkQueue = [[ASINetworkQueue alloc] init];
        [networkQueue setUploadProgressDelegate:pb];
        [networkQueue setShowAccurateProgress:YES];
        [networkQueue addOperation:request];    // 非同期通信
        [networkQueue go];
        
        NSLog(@"プログレスバー使用");
    }
}

- (void)postSucceeded:(ASIFormDataRequest*)request
{
    NSString *resString = [request responseString];
    NSLog(@"%@", resString);
}

- (void)postFailed:(ASIFormDataRequest*)request
{
    NSString *resString = [request responseString];
    NSLog(@"%@", resString);
}


@end
