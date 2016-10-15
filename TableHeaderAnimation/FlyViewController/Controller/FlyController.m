//
//  FlyController.m
//  动画第二次分享
//
//  Created by Lishten on 15/8/24.
//  Copyright (c) 2015年 Lishten. All rights reserved.
//

//#import "co"
#import "FlyController.h"
#import "FlyTableView.h"
#import "FlyCell.h"
/**
 *  设备宽度
 */
#define UI_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
/**
 *  设备高度
 */
#define UI_SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

const CGFloat BackGroupHeight = 200;

@interface FlyController()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageName;
@property (nonatomic, strong) NSArray *titleName;

@property (nonatomic, assign) CGFloat oldContetOffset;
@property (nonatomic, assign) CGFloat oldAngle;

@property (nonatomic, strong) UITableView *demoTableView;
@property (nonatomic, strong) UIImageView *imageBG;
@property (nonatomic, strong) UIView *flyBackView;
@property (nonatomic, strong) UIImageView *flyImageView;

@property (nonatomic, strong)  UIView *Tableeader;
@property (nonatomic, strong) CAShapeLayer *shaperLayer;
@property (nonatomic, strong) UIBezierPath *flyPath;

@property (nonatomic, assign) CGFloat angle;
@end

@implementation FlyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     self.automaticallyAdjustsScrollViewInsets=NO;
    [self setImageName];
    [self setupUI];
    [self initWithHeaderView];
    [self initWithFlyPath];
}

- (void)viewWillAppear:(BOOL)animated
{

}

-(void)setupUI
{
    self.imageBG=[[UIImageView alloc]init];
    self.imageBG.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH, 160);
    self.imageBG.image=[UIImage imageNamed:@"images-3.jpeg"];
    [self.view addSubview:self.imageBG];
    
    self.oldContetOffset = 0;
    self.oldAngle = 0;
    self.demoTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.demoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.demoTableView.backgroundColor = [UIColor clearColor];
    self.demoTableView.delegate=self;
    self.demoTableView.dataSource=self;
    [self.demoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.demoTableView.frame=[UIScreen mainScreen].bounds;
    self.demoTableView.showsVerticalScrollIndicator =NO;
    [self.view addSubview:self.demoTableView];
}

- (void)initWithHeaderView
{
    self.Tableeader = [[UIView alloc]initWithFrame:CGRectMake(0, 64, UI_SCREEN_WIDTH, 160)];
    self.Tableeader.backgroundColor = [UIColor clearColor];
   
    self.flyBackView = [[UIView alloc]initWithFrame:CGRectMake(10, 135, 50, 50)];
    self.flyBackView.layer.cornerRadius = 25;
    self.flyBackView.backgroundColor = [UIColor colorWithRed:27.45/256 green:51.70/256 blue:98.89/256 alpha:1];
    [self.Tableeader addSubview:self.flyBackView];
   
    self.flyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 147.5, 30, 25)];
    self.flyImageView.image = [UIImage imageNamed: @"ic_send"];
    [self.Tableeader addSubview:self.flyImageView];

    self.demoTableView.tableHeaderView = self.Tableeader;
}
- (void)initWithFlyPath
{
    self.flyPath = [[UIBezierPath alloc] init];
    [self.flyPath moveToPoint:CGPointMake(35, 160)];
    [self.flyPath addCurveToPoint:CGPointMake( -300,100) controlPoint1:CGPointMake(2*UI_SCREEN_WIDTH, -200) controlPoint2:CGPointMake(35, 160)];
    [self.flyPath moveToPoint:CGPointMake(0, 160)];
    [self.flyPath addLineToPoint:CGPointMake(35, 160)];
    
    //create shape layer
    self.shaperLayer = [CAShapeLayer layer];
    self.shaperLayer.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 160);
    self.shaperLayer.strokeColor = [UIColor clearColor].CGColor;
    self.shaperLayer.fillColor = [UIColor clearColor].CGColor;
    self.shaperLayer.lineWidth = 1;
    self.shaperLayer.lineJoin = kCALineJoinRound;
    self.shaperLayer.lineCap = kCALineCapRound;
    self.shaperLayer.path = self.flyPath.CGPath;
    //add it to our view
    [self.Tableeader.layer addSublayer: self.shaperLayer];

}
- (void)setImageName
{
    self.imageName = [NSArray array];
    self.imageName = @[@"ic_assessment_white_24dp",
                       @"ic_folder_white_24dp",
                       @"ic_smartphone_white_24dp"];
    
    self.titleName = [NSArray array];
    self.titleName = @[@"assessment",
                       @"folder",
                       @"smartphone"];
   
}
#pragma mark - tableViewDelegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 30)];
    sectionHeader.backgroundColor = [UIColor clearColor];
  
    return sectionHeader;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger index  =arc4random_uniform(2+1);
    NSString *str = self.imageName[index];
    FlyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlyCell"];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FlyCell" owner:[FlyCell class] options:nil];
        cell = (FlyCell *)[nib objectAtIndex:0];
    }
    cell.leftImage.image = [UIImage imageNamed:str];
    cell.title.textColor = [UIColor grayColor];
    cell.title.text = self.titleName[index];
    [cell setAnimation];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    CGFloat yOffset  = scrollView.contentOffset.y;
//    CGFloat xOffset = (yOffset + 160)/2;
//  NSLog(@"yOffset --- %fl",yOffset);
    //背景图片下拉放大
    if (yOffset < 0) {
        CGRect rect = self.imageBG.frame;
        rect.origin.y = 0;
        rect.size.height =  -yOffset + 160 ;
        rect.origin.x = yOffset/2;
        rect.size.width = UI_SCREEN_WIDTH + -yOffset;
        self.imageBG.frame = rect;
    }
   
    //飞机头部旋转角度
    if (yOffset < self.oldContetOffset) {
        self.angle += (1.f * M_PI)/180.0f;
        if (self.angle < 0.5) {
            [UIView animateWithDuration:0.35 animations:^{
                self.flyImageView.transform = CGAffineTransformMakeRotation(-self.angle);
            }];
        }

    } else {
        [UIView animateWithDuration:0.35 animations:^{
        self.flyImageView.transform = CGAffineTransformIdentity;
        }];
    }

    CGFloat alpha = -yOffset/160;
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    alpha=fabs(alpha);
    alpha=fabs(1-alpha);
    alpha=alpha<0.2? 0:alpha-0.2;
    self.oldContetOffset = yOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    void (^finishBlock)(void) = ^{
        
        [self.demoTableView reloadData];
    
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        finishBlock();
    });
    
    self.angle = 0;
    if (scrollView.contentOffset.y < 0) {
        CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
        animation1.keyPath = @"position";
        animation1.path = self.flyPath.CGPath;
        animation1.duration = 5;
        animation1.rotationMode = kCAAnimationRotateAuto;
        animation1.timingFunctions  = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
//                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]
                                        ];

        
        [self.flyImageView.layer addAnimation:animation1 forKey:nil];
    }

    
    if (scrollView.contentOffset.y < 0) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.demoTableView.contentOffset = CGPointMake(0, 0);
        } completion:nil];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
