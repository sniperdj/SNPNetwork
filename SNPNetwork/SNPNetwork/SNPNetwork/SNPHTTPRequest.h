//
//  SNPHTTPRequest.h
//  SNPNetwork
//
//  Created by Sniper on 2019/1/6.
//  Copyright © 2019 Sniper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNPHTTPRequest : NSObject

/** 请求url */
@property (nonatomic, copy)NSString *url;
/** 请求头 */
@property (nonatomic, strong)NSDictionary *headers;
/** 请求体 */
@property (nonatomic, strong)NSDictionary *params;


@end

NS_ASSUME_NONNULL_END
