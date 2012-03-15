//
//  MD5EncryptProcess.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-7.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MD5EncryptProcess.h"





@implementation MD5EncryptProcess

+(NSString *)md5:(NSString *)str {
	
	const char *cStr = [str UTF8String];
	
	unsigned char result[16];
	
	CC_MD5( cStr, strlen(cStr), result );
	
	return [NSString stringWithFormat:
			
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			
			result[0], result[1], result[2], result[3], 
			
			result[4], result[5], result[6], result[7],
			
			result[8], result[9], result[10], result[11],
			
			result[12], result[13], result[14], result[15]
			
			]; 
	
}

@end

