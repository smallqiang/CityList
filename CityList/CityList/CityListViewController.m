//
//  CityListViewController.m
//  CityList
//
//  Created by Chen Yaoqiang on 14-3-6.
//
//

#import "CityListViewController.h"

@interface CityListViewController ()

@end

@implementation CityListViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州市",@"北京市",@"天津市",@"西安市",@"重庆市",@"沈阳市",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市", nil];
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getCityData];
    
	// Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //添加热门城市
    NSString *strHot = @"热";
    [self.keys insertObject:strHot atIndex:0];
    [self.cities setObject:_arrayHotCity forKey:strHot];
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    
    NSString *key = [_keys objectAtIndex:section];
    if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    }
    else
        titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setTextColor:[UIColor blackColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
