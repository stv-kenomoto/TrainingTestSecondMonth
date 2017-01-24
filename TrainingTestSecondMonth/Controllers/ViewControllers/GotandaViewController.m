//
//  GotandaViewController.m
//  TrainingTestSecondMonth
//
//  Created by Kouki Enomoto on 2017/01/23.
//  Copyright © 2017年 enomt. All rights reserved.
//

#import "GotandaViewController.h"
#import "GotandaViewDataSource.h"
#import "HotPepperAPI.h"
#import "UIImage+ImageNamed.h"

static const NSInteger footerViewHeight = 60;

@interface GotandaViewController () <HotPepperAPIDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (strong, nonatomic) UIActivityIndicatorView *footerIndicatorView;
@property (strong, nonatomic) UIButton *footerRefreshButton;

@property (strong, nonatomic) GotandaViewDataSource *gotandaViewDataSource;
@property (strong, nonatomic) HotPepperAPI *hotPepperAPI;

@end

@implementation GotandaViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupFooterIndicatorView];
    [self setupFooterRefreshButton];
    [self setupAPI];
    [self.hotPepperAPI fetchGotandaGourmet];
}

#pragma mark - Action

- (IBAction)didTouchRefresh:(id)sender {
    [self hideTableView];
    [self showIndicator];
    [self hideErrorView];
    [self.hotPepperAPI fetchGotandaGourmet];
}

- (void)didTouchFooterRefresh:(id)sender {
    [self hideFooterRefreshButton];
    [self showFooterIndicatorView];
    [self.hotPepperAPI addGotandaGourmet];
}

- (void)didValueChangedRefreshControl:(id)sender {
    [self.hotPepperAPI fetchGotandaGourmet];
}

#pragma mark - Private

- (CGRect)footerFrame {
    CGRect footerFrame = self.tableView.tableFooterView.frame;
    footerFrame.size.height += footerViewHeight;
    return footerFrame;
}

- (void)setupTableView {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(didValueChangedRefreshControl:) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
    self.tableView.delegate = self;
}

- (void)setupFooterIndicatorView {
    self.footerIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.footerIndicatorView.color = [UIColor darkGrayColor];
    self.footerIndicatorView.hidesWhenStopped = YES;
    [self.footerIndicatorView stopAnimating];
}

- (void)setupFooterRefreshButton {
    self.footerRefreshButton = [[UIButton alloc] init];
    [self.footerRefreshButton setImage:[UIImage refresh] forState:UIControlStateNormal];
    self.footerRefreshButton.hidden = YES;
    [self.footerRefreshButton addTarget:self action:@selector(didTouchFooterRefresh:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupAPI {
    self.hotPepperAPI = [[HotPepperAPI alloc] init];
    self.hotPepperAPI.delegate = self;
}

- (void)showTableView {
     self.tableView.hidden = NO;
}

- (void)showIndicator {
    [self.indicatorView startAnimating];
}

- (void)showFooterIndicatorView {
    [self.footerIndicatorView startAnimating];
    self.footerIndicatorView.frame = [self footerFrame];
    self.tableView.tableFooterView = self.footerIndicatorView;
}

- (void)showFooterRefreshButton {
    self.footerRefreshButton.hidden = NO;;
    self.footerRefreshButton.frame = [self footerFrame];
    self.tableView.tableFooterView = self.footerRefreshButton;
}

- (void)showErrorView {
    self.refreshButton.hidden = NO;
    self.errorLabel.hidden = NO;
}

- (void)hideTableView {
    self.tableView.hidden = YES;
}

- (void)hideIndicator {
    [self.indicatorView stopAnimating];
}

- (void)hideFooterIndicatorView {
    [self.footerIndicatorView stopAnimating];
    [self.footerIndicatorView removeFromSuperview];
    self.tableView.tableFooterView = nil;
}

- (void)hideFooterRefreshButton {
    self.footerRefreshButton.hidden = YES;
    [self.footerRefreshButton removeFromSuperview];
    self.tableView.tableFooterView = nil;
}

- (void)hideErrorView {
    self.refreshButton.hidden = YES;
    self.errorLabel.hidden = YES;
}

- (void)renderTableViewWithGourmets:(NSArray<Gourmet *> *)gourmets {
    self.gotandaViewDataSource = [[GotandaViewDataSource alloc] initWithGourmets:gourmets];
    self.tableView.dataSource = self.gotandaViewDataSource;
    [self.tableView reloadData];
    [self showTableView];
    [self hideIndicator];
    [self hideErrorView];

    if ([self.tableView.refreshControl isRefreshing]) {
        [self.tableView.refreshControl endRefreshing];
    }
}

- (void)updateTableViewWithGourmets:(NSArray<Gourmet *> *)gourmets {
    [self hideFooterIndicatorView];
    self.gotandaViewDataSource.gourmets = [[self.gotandaViewDataSource.gourmets arrayByAddingObjectsFromArray:gourmets] mutableCopy];
    [self.tableView reloadData];
}

- (void)showError {
    if ([self.tableView.refreshControl isRefreshing]) {
        [self.tableView.refreshControl endRefreshing];
    }else {
        [self hideTableView];
        [self hideIndicator];
        [self showErrorView];
    }
}

- (void)showFooterError {
    [self hideFooterIndicatorView];
    [self showFooterRefreshButton];
}

#pragma mark - HotPepperAPIDelegate
-(void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI fetchResponse:(NSArray<Gourmet *> *)fetchResponse {
    [self renderTableViewWithGourmets:fetchResponse];
}

- (void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI fetchError:(NSError *)fetchError {
    [self showError];
}

- (void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI addResponse:(NSArray<Gourmet *> *)addResponse {
    [self updateTableViewWithGourmets:addResponse];
}

- (void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI addError:(NSError *)addError {
    [self showFooterError];
}

- (void)hotPepperAPI:(HotPepperAPI *)hotPepperAPI overResultAvailable:(NSInteger)overResultAvailable {
    [self hideFooterIndicatorView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.footerRefreshButton.isHidden) {
        return;
    }

    if (self.tableView.contentOffset.y >= self.tableView.contentSize.height - self.tableView.bounds.size.height) {
        if (self.footerIndicatorView.isAnimating) {
            return;
        }

        [self showFooterIndicatorView];
        [self.hotPepperAPI addGotandaGourmet];
    }
}

@end
