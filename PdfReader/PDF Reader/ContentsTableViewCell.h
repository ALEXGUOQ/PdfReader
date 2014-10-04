//
//  ContentsTableViewCell.h
//  MyPdfReader
//
//  Created by chang on 14-9-2.
//  Copyright (c) 2014年 chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentsTableViewCell : UITableViewCell


@property(nonatomic) BOOL isUnfold;// 是否展开
//@property(nonatomic,retain) NSString * subContentsArray;// 点击cell显示子内容
@property(nonatomic,weak)IBOutlet UIImageView *imageView;// 显示按钮

@end
