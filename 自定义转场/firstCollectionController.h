//
//  firstCollectionController.h
//  自定义转场
//
//  Created by 黄少华 on 15/7/23.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface firstCollectionController : UICollectionViewController

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGRect finalCellRect;
@end
