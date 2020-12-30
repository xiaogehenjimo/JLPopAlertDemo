//
//  ViewController.m
//  JLPopAlertDemo
//
//  Created by xuqinqiang on 2020/12/30.
//

#import "ViewController.h"
#import "JLGeneralWarnAlertView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = @[@"底部弹出底部消失", @"底部弹出顶部消失", @"顶部弹出顶部消失", @"顶部弹出底部消失", @"渐变", @"缩放", @"无动画"];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JLGeneralWarnAlertView *alert = [[JLGeneralWarnAlertView alloc] initWithTitle:@"这是标题(可选)" content:@"这是内容(可选)" cancelBtnTitle:@"取消(可选)" determineBtnTitle:@"确定(可选)" cancelBlock:^{
        NSLog(@"取消回调");
    } determineBlock:^{
        NSLog(@"确定回调");
    }];
    [alert showInWindowWithAnimation:indexPath.row + 1]; //window
    //[alert showWithAnimation:indexPath.row + 1]; //present
}

#pragma mark - get

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

@end
