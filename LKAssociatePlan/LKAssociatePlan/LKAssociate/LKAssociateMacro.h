//
//  LKAssociateMacro.h
//  LKAssociatePlan
//
//  Created by 宋金峰 on 2019/2/13.
//  Copyright © 2019 宋金峰. All rights reserved.
//

#ifndef LKAssociateMacro_h
#define LKAssociateMacro_h

#define LKASSOCIATESELECTNOTIFICATION @"lk_associate_selectnotification"


#ifndef SafeString
#define SafeString(A) A?A:@""
#endif



#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#if __has_include(<MJExtension/MJExtension.h>)
#import <MJExtension/MJExtension.h>
#else
#import "MJExtension.h"
#endif

#if __has_include(<FMDB/FMDB.h>)
#import <FMDB/FMDB.h>
#else
#import "FMDB.h"
#endif

#endif /* LKAssociateMacro_h */
