//
//  NSString+DP.m
//  DPCalendar
//
//  Created by Shan Wang on 20/04/2014.
//  Copyright (c) 2014 Ethan Fang. All rights reserved.
//

#import "NSString+DP.h"
#import "DPConstants.h"

#import <UIKit/UIKit.h>

@implementation NSString (DP)

-(CGRect)dp_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes context:(NSStringDrawingContext *)context {
    return [self boundingRectWithSize:size
                                           options:options
                                        attributes:attributes context:context];
    
}

- (void)dp_drawAtPoint:(CGPoint)point withAttributes:(NSDictionary *)attrs {
    [self drawAtPoint:point withAttributes:attrs];
}

- (void)dp_drawInRect:(CGRect)rect withAttributes:(NSDictionary *)attrs {
    [self drawInRect:rect withAttributes:attrs];
}

@end
