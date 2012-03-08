//
//  UpgradeChecker.m
//  SanTel
//
//  Created by liuxueyan on 8/6/10.
//  Copyright 2010 Sanntuu. All rights reserved.
//


#import "UpgradeChecker.h"
#import "NewsGatheringAppDelegate.h"

@implementation UpgradeChecker

@synthesize parsestate;

- (id)init {
	if ([super init]) {
		self.parsestate         = STATE_ROOT;
		_dict = [[NSMutableDictionary alloc] init];
	}
	return self;
}

-(void)main {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSURL *url            = [NSURL URLWithString:@"http://"];
	NSMutableURLRequest *req     = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
	//[req setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
	
	if ([NSURLConnection canHandleRequest:req]) {
		NSError *err       = nil;
		NSData *adXML = [NSData dataWithContentsOfURL:url options:NSUncachedRead error:&err];
		NSXMLParser *parser = [[NSXMLParser alloc] initWithData:adXML];
		[parser setDelegate:self];
		[parser parse];
		[parser release];
		
		NewsGatheringAppDelegate *app = (NewsGatheringAppDelegate *) [UIApplication sharedApplication];
		NSTimer *timer = [NSTimer
						  timerWithTimeInterval:0 target:app
						  selector:@selector(checkUpgrade:)
						  userInfo:_dict repeats:NO];
		[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
		
	}
	
	[pool release];
}

////////////////////////////////
// NSXMLParser Delegates [start]
////////////////////////////////
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	
	if (self.parsestate == STATE_ROOT) {
		if ([elementName isEqualToString:@"VersionInfo"]) {
			self.parsestate         = STATE_VERINFO;
		}
	}
	else if (self.parsestate == STATE_VERINFO) {
		if ([elementName isEqualToString:@"Application"]) {
			self.parsestate = STATE_APP;
		}
		else if ([elementName isEqualToString:@"Version"]) {
			self.parsestate = STATE_VER;
		}
		else if ([elementName isEqualToString:@"AppStore"]) {
			self.parsestate = STATE_APPSTORE;
		}
	}
	
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if (self.parsestate == STATE_VERINFO) {
		if ([elementName isEqualToString:@"VersionInfo"]) {
			self.parsestate = STATE_ROOT;
		}
	}
	else if (self.parsestate == STATE_APP) {
		if ([elementName isEqualToString:@"Application"]) {
			self.parsestate = STATE_VERINFO;
		}
	}
	else if (self.parsestate == STATE_VER) {
		if ([elementName isEqualToString:@"Version"]) {
			self.parsestate = STATE_VERINFO;
		}
	}
	else if(self.parsestate == STATE_APPSTORE) {
		if ([elementName isEqualToString:@"AppStore"]) {
			self.parsestate = STATE_VERINFO;
		}
	}
	
}
		

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
	[self
	 parser:parser
	 foundCharacters:[[[NSString alloc]
										 initWithData:CDATABlock
										 encoding:NSUTF8StringEncoding] autorelease]];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (self.parsestate == STATE_VER) {
		[_dict setObject:string forKey:@"Version"];
	}
	else if (self.parsestate == STATE_APPSTORE) {
		[_dict setObject:string forKey:@"AppStore"];
	}
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	self.parsestate = STATE_ROOT;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	self.parsestate = STATE_ROOT;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSLog(@"ad error parsing (%@)", parseError);
	[parser abortParsing];
}

///////////////////////////////
// NSXMLParser Delegates [stop]
///////////////////////////////

- (void)dealloc {
	[_dict release];
	[super dealloc];
}



@end
