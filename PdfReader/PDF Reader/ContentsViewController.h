//
//  ContentsViewController.h
//  PDFContents
//
//  Created by Leon on 1/14/14.
//  Copyright (c) 2014 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentsCallbackDelegate;


@interface ContentsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *contents;

@property (weak, nonatomic) id<ContentsCallbackDelegate> contentsCallbackDelegate;

@property(nonatomic,weak)IBOutlet UITableView *myTableView;
@end


@protocol ContentsCallbackDelegate <NSObject>
@optional
#pragma mark - 目录点击index回调
- (void)contentsCallback:(NSInteger)object;
@end