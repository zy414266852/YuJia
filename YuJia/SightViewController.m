//
//  SightViewController.m
//  YuJia
//
//  Created by wylt_ios_1 on 2017/5/4.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "SightViewController.h"
#import "UIColor+Extension.h"
#import "JXSegment.h"
#import "JXPageView.h"
#import "EquipmentTableViewCell.h"
#import "SightSettingViewController.h"
#import "AddEquipmentViewController.h"
#import "EquipmentViewController.h"
#import "SightViewController.h"
#import "SightModel.h"
#import "EquipmentModel.h"
#import "LightSettingViewController.h"
#import "AirConditioningViewController.h"
#import "TVSettingViewController.h"
#import "DoorLockViewController.h"
#import "SocketSettingViewController.h"
#import "CurtainSettingViewController.h"
@interface SightViewController ()<JXSegmentDelegate,JXPageViewDataSource,JXPageViewDelegate, UITabBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    JXPageView *pageView;
    JXSegment *segment;
    UIImageView *navBarHairlineImageView;
    UIImageView *tabBarHairlineImageView;
}
@property (nonatomic, strong) NSMutableArray *nameList;

@property (nonatomic, assign) NSInteger loadTableV;
@property (nonatomic, strong) NSMutableArray *tableViews;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIButton *startBtn;
@end

@implementation SightViewController

- (NSMutableArray *)nameList{
    if (_nameList == nil) {
        _nameList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _nameList;
}

- (NSMutableArray *)tableViews{
    if (_tableViews == nil) {
        _tableViews = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _tableViews;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.title = @"家";
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%ld",self.dataSource.count);
    for (SightModel *sightModel in self.dataSource) {
        [self.nameList addObject:sightModel.sceneName];
    }
    
    
    [self setupSlideBar];
    self.currentIndex = 0;
    
    
    UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [starBtn setTitle:@"一键开启" forState:UIControlStateNormal];
    [starBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    starBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    starBtn.backgroundColor = [UIColor colorWithHexString:@"00bfff"];
    starBtn.layer.cornerRadius = 40;
    starBtn.clipsToBounds = YES;
    [starBtn addTarget:self action:@selector(buttonClick_Start:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:starBtn];
    self.startBtn = starBtn;
    WS(ws);
    [starBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view).with.offset(-15 -49);
        make.right.equalTo(ws.view).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(80 ,80));
    }];
    
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"index = %ld",Index);
    switch (Index)
    {
            //        case 0:
            //            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kSrcName(@"bg_apple_small.png")]];
            //            break;
            //        case 1:
            //            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kSrcName(@"bg_orange_small.png")]];
            //            break;
            //        case 2:
            //            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kSrcName(@"bg_banana_small.png")]];
            //            break;
            //        default:
            //            break;
    }
}
- (void)setupSlideBar {
    segment = [[JXSegment alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
//    [segment updateChannels:@[@"首页",@"文章",@"好东西",@"早点与宵夜",@"电子小物",@"苹果",@"收纳集合",@"JBL",@"装b利器",@"测试机啦啦",@"乱七八糟的"]];
    [segment updateChannels:self.nameList];
    segment.delegate = self;
    [self.view addSubview:segment];
    
    pageView =[[JXPageView alloc] initWithFrame:CGRectMake(0, 40, kScreenW, self.view.bounds.size.height - 148 -10)];
    pageView.datasource = self;
    pageView.delegate = self;
    [pageView reloadData];
//    for(int i = 0 ; i<self.nameList.count;i++){
//        NSLog(@"i === %d",i);
//        [pageView changeToItemAtIndex:i];
//    }
    if (self.nameList.count >0) {
        [pageView changeToItemAtIndex:0];
    }
    
    
    [self.view addSubview:pageView];
}
#pragma mark - JXPageViewDataSource
-(NSInteger)numberOfItemInJXPageView:(JXPageView *)pageView{
    NSLog(@"刷新后的 页面有%ld",self.dataSource.count);
    return self.dataSource.count;
}

-(UIView*)pageView:(JXPageView *)pageView viewAtIndex:(NSInteger)index{
//    NSLog(@"view  index =  %ld",index);
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[self randomColor]];
    
    self.loadTableV = index;
    ////////////////////////////
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, kScreenW, kScreenH -104 - 44) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tag = 100 +index;
    tableView.rowHeight = kScreenW *77/320.0 +10;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [tableView registerClass:[EquipmentTableViewCell class] forCellReuseIdentifier:@"EquipmentTableViewCell"];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    SightModel *sightModel = self.dataSource[index];
    if (sightModel.equipmentList.count == 0) {
        tableView.tableFooterView = [self createTableFootView];
    }
    
    [self.tableViews addObject:tableView];
    ////////////////////////////
    return tableView;
}

#pragma mark - JXSegmentDelegate
- (void)JXSegment:(JXSegment*)segment didSelectIndex:(NSInteger)index{
    [pageView changeToItemAtIndex:index];
}

#pragma mark - JXPageViewDelegate
- (void)didScrollToIndex:(NSInteger)index{
    [segment didChengeToIndex:index];
//    NSLog(@"index = %ld",index);
}


- (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
#pragma mark -
#pragma mark ------------TableView Delegeta----------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"select = %ld",tableView.tag -100);
    SightModel* sightModel;
    EquipmentModel *equipmentModel;
    if (self.dataSource.count == 0) {
    }else{
        sightModel = self.dataSource[tableView.tag -100];
    }
    if (sightModel.equipmentList.count != 0) {
        equipmentModel = sightModel.equipmentList[indexPath.row];
    }
    
    if (indexPath.section == 0) {
        SightSettingViewController *sightVC = [[SightSettingViewController alloc]init];
        sightVC.sightModel = self.dataSource[segment.selectedIndex];
        [self.navigationController pushViewController:sightVC animated:YES];
    }else{
        switch ([equipmentModel.iconId integerValue]) {
            case 2:{
                LightSettingViewController *sightVC = [[LightSettingViewController alloc]init];
                //        sightVC.sightModel = self.dataSource[segment.selectedIndex];
                [self.navigationController pushViewController:sightVC animated:YES];
            }
                
                break;
            case 1:{
                SocketSettingViewController *sightVC = [[SocketSettingViewController alloc]init];
                //        sightVC.sightModel = self.dataSource[segment.selectedIndex];
                [self.navigationController pushViewController:sightVC animated:YES];
            }
                
                break;
            case 3:{
                TVSettingViewController *sightVC = [[TVSettingViewController alloc]init];
                //        sightVC.sightModel = self.dataSource[segment.selectedIndex];
                [self.navigationController pushViewController:sightVC animated:YES];
            }
                
                break;
            case 4:{
                CurtainSettingViewController *sightVC = [[CurtainSettingViewController alloc]init];
                //        sightVC.sightModel = self.dataSource[segment.selectedIndex];
                [self.navigationController pushViewController:sightVC animated:YES];
            }
                
                break;
            case 5:{
                AirConditioningViewController *sightVC = [[AirConditioningViewController alloc]init];
                //        sightVC.sightModel = self.dataSource[segment.selectedIndex];
                [self.navigationController pushViewController:sightVC animated:YES];
            }
                
                break;
            case 6:{
                DoorLockViewController *sightVC = [[DoorLockViewController alloc]init];
                //        sightVC.sightModel = self.dataSource[segment.selectedIndex];
                [self.navigationController pushViewController:sightVC animated:YES];
            }
                break;
                
            default:
                break;
        }

    }
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        SightModel* sightModel;
        if (self.dataSource.count == 0) {
            return 0;
        }else{
            
            sightModel = self.dataSource[tableView.tag - 100];
            
            return sightModel.equipmentList.count;
        }
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"select = %ld",tableView.tag -100);
    SightModel* sightModel;
    EquipmentModel *equipmentModel;
    if (self.dataSource.count == 0) {
    }else{
        sightModel = self.dataSource[tableView.tag -100];
    }
    if (sightModel.equipmentList.count != 0) {
        equipmentModel = sightModel.equipmentList[indexPath.row];
    }
//    NSLog(@"第%ld row个数 %ld",tableView.tag -100,indexPath.row);
    // 图标  情景设置setting  灯light 电视tv 插座socket
    EquipmentTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"EquipmentTableViewCell" forIndexPath:indexPath];
    homeTableViewCell.equipmentModel = equipmentModel;
    if (indexPath.section == 0) {
        homeTableViewCell.titleLabel.text = @"情景设置";
        homeTableViewCell.iconV.image = [UIImage imageNamed:@"setting"];
        [homeTableViewCell cellMode:NO];
    }else{
        homeTableViewCell.titleLabel.text = equipmentModel.name;
        if (equipmentModel.iconUrl.length >0) {
            
        }else{
            homeTableViewCell.titleLabel.text = equipmentModel.name;
            homeTableViewCell.iconV.image = [UIImage imageNamed:mIcon[[equipmentModel.iconId integerValue] ]];
        }
        [homeTableViewCell cellMode:YES];
        if ([equipmentModel.state isEqualToString:@"0"]) {
            homeTableViewCell.switch0.on = YES;
        }else{
            homeTableViewCell.switch0.on = NO;
        }
        
    }
    [homeTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return homeTableViewCell;
}
- (void)action:(NSString *)actionStr{
    NSLog(@"点什么点");
}
- (void)segmentAction:(UISegmentedControl *)action{
//    NSLog(@"  %ld",action.selectedSegmentIndex);
//    if (action.selectedSegmentIndex == 0) {
//        [segment updateChannels:@[@"首页",@"文章",@"好东西",@"早点与宵夜",@"电子小物",@"苹果",@"收纳集合",@"JBL",@"装b利器",@"测试机啦啦",@"乱七八糟的"]];
//    }else{
//        [segment updateChannels:@[@"客厅",@"lim的卧室",@"厨房",@"卫生间",@"电子小物"]];
//    }
}
- (void)addEquipment{
    AddEquipmentViewController *addEquipmentVC  = [[AddEquipmentViewController alloc]init];
    [self.navigationController pushViewController:addEquipmentVC animated:YES];
}
- (void)buttonClick_Start:(UIButton *)btn{
    NSLog(@"点点");
    NSDictionary *dict = @{@"id":@"1",@"scene_state":@"1",@"token":@"9DB2FD6FDD2F116CD47CE6C48B3047EE"};
    
    [[HttpClient defaultClient]requestWithPath:mSightStart method:1 parameters:dict prepareExecute:^{
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"提交成功%@",responseObject);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"设置成功" preferredStyle:UIAlertControllerStyleAlert];
            //       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            //       [alert addAction:cancelAction];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];

    
}
- (void)reloadData:(NSArray *)newDataSource{
    
    

    NSInteger index = segment.selectedIndex;
    NSLog(@"当前选中的%ld",index);
    self.dataSource = newDataSource;
    [self.nameList removeAllObjects];
    for (SightModel *sightModel in self.dataSource) {
        [self.nameList addObject:sightModel.sceneName];
    }
    [segment updateChannels:self.nameList];
    
    
    [self.tableViews removeAllObjects];
    pageView = nil;
    pageView =[[JXPageView alloc] initWithFrame:CGRectMake(0, 40, kScreenW, self.view.bounds.size.height - 148 -10)];
    pageView.datasource = self;
    pageView.delegate = self;
    [pageView reloadData];
    if (self.nameList.count >0) {
        [pageView changeToItemAtIndex:0];
    }
    
    
    [self.view addSubview:pageView];
    if (index < self.dataSource.count) {
        [segment didChengeToIndex:index];
    }
    
    [self.view bringSubviewToFront:self.startBtn];
    
}
- (UIView *)createTableFootView{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 500)];
    footView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    
    UIView *clickView = [[UIView alloc]init];
    clickView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emptyClick)];
    [clickView addGestureRecognizer:tapGest];
    [footView addSubview:clickView];
    [clickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footView).with.offset(90);
        make.centerX.equalTo(footView);
        make.size.mas_equalTo(CGSizeMake(160, 230));
    }];
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nodevice"]];
    [clickView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clickView);
        make.centerX.equalTo(clickView);
        make.size.mas_equalTo(CGSizeMake(160, 160));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"还没添加设备哦！";
    titleLabel.textColor = [UIColor colorWithHexString:@"cccccc"];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [clickView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).with.offset(15);
        make.centerX.equalTo(clickView);
        make.size.mas_equalTo(CGSizeMake(160, 13));
    }];
    
    
    UILabel *titleLabel2 = [[UILabel alloc]init];
    titleLabel2.text = @"去添加吧！";
    titleLabel2.textColor = [UIColor colorWithHexString:@"cccccc"];
    titleLabel2.font = [UIFont systemFontOfSize:13];
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    [clickView addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(10);
        make.centerX.equalTo(clickView);
        make.size.mas_equalTo(CGSizeMake(160, 13));
    }];
    
    return footView;
    
}
- (void)emptyClick{
    SightSettingViewController *sightVC = [[SightSettingViewController alloc]init];
    sightVC.sightModel = self.dataSource[segment.selectedIndex];
    [self.navigationController pushViewController:sightVC animated:YES];
}

@end
