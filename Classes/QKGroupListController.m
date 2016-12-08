//
//  QKGroupListController.m
//  QKGroupListExample
//
//  Created by 丁乾坤 on 2016/12/8.
//  Copyright © 2016年 丁乾坤. All rights reserved.
//

#import "QKGroupListController.h"
#import "QKGroupListCell.h"
#import "QKGroupListGroupNameView.h"
typedef NS_ENUM(NSInteger, MyFrienGroup) {
    MyFrienGroupClose,
    MyFrienGroupOpen = 1
};

@interface QKGroupListController ()

@property(nonatomic, strong)NSMutableDictionary *dictSource;  //数据资源

@property(nonatomic, strong)NSMutableDictionary *closeOrOpenValueDict; //记录当前分区的展开关闭的bool值

@end

@implementation QKGroupListController

static NSString *cellIdentifier = @"QKGroupListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的好友列表";
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"ceshi" ofType:@"plist"];
    NSMutableDictionary *dictSource = [NSMutableDictionary dictionaryWithContentsOfFile:strPath];
    self.dictSource = dictSource;
    self.closeOrOpenValueDict = [NSMutableDictionary dictionary];
    [self.tableView registerClass:[QKGroupListCell class] forCellReuseIdentifier:cellIdentifier];
    
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *groupName = [self.dictSource allKeys][section];
    QKGroupListGroupNameView *groupListNameView = [[QKGroupListGroupNameView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    [groupListNameView.groupNameBtn setTitle:groupName forState:UIControlStateNormal];
    [groupListNameView.groupNameBtn addTarget:self action:@selector(myFriendGruopOpenOrClose:) forControlEvents:UIControlEventTouchUpInside];
    groupListNameView.groupNameBtn.tag = 200 + section;
    //防止刷新时按钮的状态改变
    NSArray *statusArray = [self.closeOrOpenValueDict allKeys];;
    if ([statusArray containsObject:@(section).stringValue]) {
        [groupListNameView.groupNameBtn setSelected:[[self.closeOrOpenValueDict objectForKey:@(section).stringValue] integerValue]];
    }

        return groupListNameView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSArray *keysArray = [self.dictSource allKeys];
    
    return keysArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keysArray = [self.dictSource allKeys];
    NSString *keyStr = keysArray[section];
    NSArray *contentArray = [self.dictSource objectForKey:keyStr];
    NSArray *statusArray = [self.closeOrOpenValueDict allKeys];;
    if ([statusArray containsObject:@(section).stringValue]) {
        if ([[self.closeOrOpenValueDict objectForKey:@(section).stringValue] integerValue]) {
            return contentArray.count;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKGroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell) {
        cell = [[QKGroupListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSArray *keysArray = [self.dictSource allKeys];
    NSString *keyStr = keysArray[indexPath.section];
    NSArray *contentArray = [self.dictSource objectForKey:keyStr];
    cell.textLabel.text = contentArray[indexPath.row];
    
    return cell;
}

#pragma mark  ----- 单击事件
- (void)myFriendGruopOpenOrClose:(UIButton *)sender{
    [sender setSelected:!sender.selected];
    NSMutableArray *keysArray = (NSMutableArray *)[self.closeOrOpenValueDict allKeys];
    NSInteger index = sender.tag - 200;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    if (![keysArray containsObject:@(index).stringValue]) {
        [self.closeOrOpenValueDict setObject:@(MyFrienGroupOpen) forKey:@(index).stringValue];
    }else{
        NSNumber *status = [self.closeOrOpenValueDict objectForKey:@(index).stringValue];
        if(status.integerValue){
            [self.closeOrOpenValueDict setObject:@(MyFrienGroupClose) forKey:@(index).stringValue];
        }else{
            [self.closeOrOpenValueDict setObject:@(MyFrienGroupOpen) forKey:@(index).stringValue];
        }
    }
    //    [self.tableView reloa];
    //    [self.tableView reloadData];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}




@end
