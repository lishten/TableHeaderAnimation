//
//  FlyTableView.m
//  动画第二次分享
//
//  Created by Lishten on 15/8/24.
//  Copyright (c) 2015年 Lishten. All rights reserved.
//

#import "FlyTableView.h"
#import "FlyHeaderView.h"

/**
 *  设备宽度
 */
#define UI_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
/**
 *  设备高度
 */
#define UI_SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

@interface FlyTableView()
@property (nonatomic, strong) FlyHeaderView *header;
@end
@implementation FlyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self initWithTableViewHeader];
       
    }
    return self;
}

- (void)initWithTableViewHeader
{
    self.header = [[FlyHeaderView alloc]initWithFrame:CGRectMake(0, -200, UI_SCREEN_WIDTH, 200)];
    self.header.backgroundColor = [UIColor redColor];
    [self addSubview:self.header];
   
}
#pragma mark -- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CGFloat r = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat g = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat b = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    cell.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + 160)/2;
    
    if (yOffset < -200) {
        
        CGRect rect = self.header.bImageView.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = UI_SCREEN_WIDTH + fabs(xOffset)*2;
        
        self.header.bImageView.frame = rect;
    }
}
@end
