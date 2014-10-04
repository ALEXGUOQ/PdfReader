//
//  ContentsViewController.m
//  PDFContents
//
//  Created by Leon on 1/14/14.
//  Copyright (c) 2014 Leon. All rights reserved.
//

#import "ContentsViewController.h"
#import "ContentsTableViewCell.h"
#import "CellObject.h"


@interface ContentsViewController ()
{
   
    NSMutableArray * tempArray;// 动态更新tableViews数据源

}
@end

@implementation ContentsViewController
@synthesize myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    tempArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<self.contents.count; i++) {
        CellObject *cellObject = [[CellObject alloc] init];
        NSDictionary *dict = [self.contents objectAtIndex:i];
        cellObject.title = dict[@"Title"];
        cellObject.index = [NSString stringWithFormat:@"%@", dict[@"Index"]];
        cellObject.subContents = dict[@"SubContents"];
        cellObject.superIndex = @"0";
        cellObject.isUnfold = NO;
        
        [tempArray addObject:cellObject];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tempArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * cellIdentifier=@"ContentsTableViewCell";
    ContentsTableViewCell * cell=(ContentsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        NSArray * nilTable=[[NSBundle mainBundle]loadNibNamed:@"ContentsTableViewCell" owner:self options:nil];
        cell=[nilTable objectAtIndex:0];
    }

    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:100];
    UILabel *numberLabel = (UILabel *)[cell.contentView viewWithTag:101];
    
    CellObject *cellObject = tempArray[indexPath.row];

    titleLabel.text = cellObject.title;
    numberLabel.text = cellObject.index;
    NSArray *subContents = cellObject.subContents;
    if (subContents && subContents.count > 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.imageView.hidden =NO;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.imageView.hidden =YES;
    }
    if (cellObject.isUnfold==YES) {
        [cell.imageView setImage:[UIImage imageNamed:@"arrowDown@2x.png"]];
    }else{
        [cell.imageView setImage:[UIImage imageNamed:@"arrowRight@2x.png"]];
    }
   
    
    for (int i=0; i<self.contents.count; i++) {
        NSDictionary *dic1 = [self.contents objectAtIndex:i];
        // 第1层数据
        NSString *str1 = [NSString stringWithFormat:@"%@",dic1[@"Index"]];
        NSString *title = dic1[@"Title"];
        if ([str1 isEqualToString:cellObject.index] && [title isEqualToString:cellObject.title]) {
            cellObject.cellLavel = @"1";// 第1层数据
        }

        NSArray * arr1 = dic1[@"SubContents"];
        if (arr1 && arr1.count>0) {
            for (int i=0; i<arr1.count; i++) {
                NSDictionary *dic2 = [arr1 objectAtIndex:i];
                // 第2层数据
                NSString *str2 = [NSString stringWithFormat:@"%@",dic2[@"Index"]];
                NSString *title2 = dic2[@"Title"];
                if ([str2 isEqualToString:cellObject.index] && [title2 isEqualToString:cellObject.title]) {
                    cellObject.cellLavel = @"2";// 第2层数据
                }
                
                NSArray * arr2 = dic2[@"SubContents"];
                if (arr2 && arr2.count>0) {
                    for (int j=0; j<arr2.count; j++) {
                        NSDictionary *dic3 = [arr2 objectAtIndex:j];
                        NSString *str3 = [NSString stringWithFormat:@"%@",dic3[@"Index"]];
                        NSString *title3 = dic3[@"Title"];
                        if ([str3 isEqualToString:cellObject.index] && [title3 isEqualToString:cellObject.title]) {
                            cellObject.cellLavel = @"3";// 第3层数据
                        }
                        NSArray * arr3 = dic3[@"SubContents"];
                        if (arr3 && arr3.count>0) {
                            cellObject.cellLavel = @"4";// 第3层及3层以上数据
                        }
                    }
                }
            }
        }
    }

    if ([@"1" isEqualToString:cellObject.cellLavel]) {
        cell.imageView.frame = CGRectMake(6, 12, 20, 20);
        titleLabel.frame = CGRectMake(30, 11, 210, 21);
    }else if([@"2" isEqualToString:cellObject.cellLavel]) {
        cell.imageView.frame = CGRectMake(16, 12, 20, 20);
        titleLabel.frame = CGRectMake(40, 11, 200, 21);
    }else if([@"3" isEqualToString:cellObject.cellLavel]) {
        cell.imageView.frame = CGRectMake(26, 12, 20, 20);
        titleLabel.frame = CGRectMake(50, 11, 190, 21);
    }else{
        cell.imageView.frame = CGRectMake(26, 12, 20, 20);
        titleLabel.frame = CGRectMake(50, 11, 190, 21);
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CellObject *cellObjcet = tempArray[indexPath.row];
    NSArray *subContents = cellObjcet.subContents;
    if (subContents && subContents.count > 0) {
        if (cellObjcet.isUnfold==NO) {
            cellObjcet.isUnfold =YES;
            for (int i=0; i<subContents.count; i++) {
                CellObject *cell = [[CellObject alloc] init];
                NSDictionary *dict = [subContents objectAtIndex:i];
                cell.title = dict[@"Title"];
                cell.index = [NSString stringWithFormat:@"%@", dict[@"Index"]];
                cell.subContents = dict[@"SubContents"];
                cell.superIndex = [NSString stringWithFormat:@"%li",indexPath.row];
                cell.isUnfold = NO;
                
                [tempArray insertObject:cell atIndex:indexPath.row+i+1];
            }

            [self.myTableView reloadData];
        }else{
            cellObjcet.isUnfold =NO;
            NSArray * subArray = cellObjcet.subContents;
            for (int i=0; i<subArray.count; i++) {
                NSDictionary * dic = [subArray objectAtIndex:i];
                NSArray *arr = dic[@"SubContents"];
                if (arr && arr.count>0) {
                    NSArray * temporaryArray = [tempArray copy];
                    for (CellObject *cell in temporaryArray) {
                        NSString *str = [NSString stringWithFormat:@"%@",dic[@"Index"]];
                        if ([str isEqualToString:cell.index]) {
                            if (cell.isUnfold==YES) {
                                cell.isUnfold=NO;
                                NSArray * sub2Contents = cell.subContents;
                                for (NSDictionary *dic2 in sub2Contents) {
                                    NSString *str2 = [NSString stringWithFormat:@"%@",dic2[@"Index"]];
                                    NSString *title = dic2[@"Title"];
                                    for (CellObject *cell2 in temporaryArray) {
                                        if ([str2 isEqualToString:cell2.index] && [title isEqualToString:cell2.title]) {
                                            [tempArray removeObject:cell2];
                                        }
                                    }
                                }
                                [tempArray removeObject:cell];
                            }else{
                              [tempArray removeObject:cell];
                            }
                        }
                    }
                    
                }else{
                    // temporaryArray为临时变量
                    NSArray * temporaryArray = [tempArray copy];
                    for (CellObject *cellObj in temporaryArray) {
                        NSString *str = [NSString stringWithFormat:@"%@",dic[@"Index"]];
                        NSString *title = dic[@"Title"];
                        if ([str isEqualToString:cellObj.index] && [title isEqualToString:cellObj.title]) {
                            [tempArray removeObject:cellObj];
                        }
                    }
                }
            }
            [self.myTableView reloadData];
        }

    }else{
    
        if ([self.contentsCallbackDelegate respondsToSelector:@selector(contentsCallback:)]) {
            [self.contentsCallbackDelegate contentsCallback:[cellObjcet.index intValue]];
        }

    }
}

@end
