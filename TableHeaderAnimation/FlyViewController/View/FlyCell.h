//
//  FlyCell.h
//  动画第二次分享
//
//  Created by Lishten on 15/8/27.
//  Copyright (c) 2015年 Lishten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
- (void)setAnimation;
@end
