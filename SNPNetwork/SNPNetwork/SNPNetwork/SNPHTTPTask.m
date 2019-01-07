//
//  SNPHTTPTask.m
//  SNPNetwork
//
//  Created by Sniper on 2019/1/6.
//  Copyright © 2019 Sniper. All rights reserved.
//

#import "SNPHTTPTask.h"
#import "AFNetworking.h"
#import "SNPHTTPRequest.h"

@implementation SNPHTTPTask

static AFHTTPSessionManager *manager = nil;

+ (AFHTTPSessionManager *)manager {
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
    return manager;
}

+ (NSURLSessionDataTask *)taskWithRequest:(SNPHTTPRequest *)request {
    [self customManagerWithRequest:request];
    if (request.reqMethod == SNPPost) {
        return [self makePostReq:request];
    } else if (request.reqMethod == SNPGet) {
        return [self makeGetReq:request];
    }
    return nil;
}

+ (void)customManagerWithRequest:(SNPHTTPRequest *)req {
    AFHTTPSessionManager *manager = [self manager];
    NSDictionary *headers = req.headers;
    // 请求头
    for (NSString *headKey in headers) {
        id headObj = [headers objectForKey:headKey];
        [manager.requestSerializer setValue:headObj forHTTPHeaderField:headKey];
    }
    // 请求格式
    if (req.requestType == SNPRequestJSON) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    } else if (req.requestType == SNPRequestHTTP) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    // 返回格式
    if (req.responseType == SNPResponseJSON) {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    } else if (req.responseType == SNPResponseHTTP) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
}
#pragma mark - 具体请求
+ (NSURLSessionDataTask *)makePostReq:(SNPHTTPRequest *)req {
    AFHTTPSessionManager *manager = [self manager];
    return [manager POST:req.url parameters:req.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (req.successBlock) {
            req.successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (req.errorBlock) {
            req.errorBlock(error);
        }
    }];
    
}

+ (NSURLSessionDataTask *)makeGetReq:(SNPHTTPRequest *)req {
    AFHTTPSessionManager *manager = [self manager];
    return [manager GET:req.url parameters:req.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (req.successBlock) {
            req.successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (req.errorBlock) {
            req.errorBlock(error);
        }
    }];
}

@end
