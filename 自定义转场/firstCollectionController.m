//
//  firstCollectionController.m
//  自定义转场
//
//  Created by 黄少华 on 15/7/23.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "firstCollectionController.h"
#import "secondViewController.h"
#import "collectionViewCell.h"
#import "TransitionAnimation.h"
@interface firstCollectionController ()<UINavigationControllerDelegate>

@end

@implementation firstCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
    
    [super viewWillAppear:animated];
    
    NSLog(@"1");

}




- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[secondViewController class]]) {
        TransitionAnimation *transition = [[TransitionAnimation alloc] init];
        
        NSLog(@"2");
        return transition;
    }else{
        return nil;
    }
        
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    secondViewController *second = segue.destinationViewController;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    collectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}



@end
