/*
 *	File:		DatePicker.m
 *	Contains:	The implemention of class DatePicker.
 *	Version:	1.0
 *	Author:		Qian Hui(hqian@cn.ufinity.com)
 *
 *  This source code is Copyright 2009 and owned by Ufinity Pte Ltd.
 *
 *	This source code is provided to SPH only for operations and maintenance of
 *	the contracted application. It cannot be re-distributed or revealed to a
 *	third party without the explicit consent of Ufinity.
 *
 *	Revision 1.0  2010/12/16 2:46:06  Qian Hui.
 *	Initial Checkin
 *
 */

#import "DatePicker.h"


/*
 *	Private methods of calss.
 */
@interface DatePicker (PrivateMethods)

/*
 *	set the date be selected.
 */
- (void)setDateSelected:(NSDate *)date;

/*
 *	Convert NSString object to NSDate object.
 *
 *	|string| is the input string.
 */
- (NSDate *)convertStringToDate:(NSString *)string;

@end


@implementation DatePicker

#define DATE_FORMATTER			@"yyyy-MM-dd HH:mm:ss"
#define DATE_PRINTF_FORMATTER	@"%d-%02d-%02d %02d:%02d:%02d"

@synthesize selectedDate = _selectedDate;

#define leap_year(yr) ((!((yr) % 4) && ((yr) % 100)) || !((yr) % 400))

static int days_in_month[2][13] = {
	{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
	{0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}, /* 闰年 */
};

#pragma mark -
#pragma mark View's methods.

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
		_pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
		_pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_pickerView.delegate = self;
		_pickerView.dataSource = self;
		_pickerView.showsSelectionIndicator = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	[super drawRect:rect];

	// Calculation the frame of |_pickerView| and add it as subview of current view.
	CGRect dateRect;
	dateRect.origin.y = CGRectGetMinY(self.bounds) + 50.0f;
	dateRect.origin.x = CGRectGetMinX(self.bounds) + 5.0f;
	dateRect.size.width = CGRectGetWidth(self.bounds)-10.0f;
	//dateRect.size.height = CGRectGetHeight(self.bounds) - 50.0f;
	dateRect.size.height = 162.0f;
	_pickerView.frame = dateRect;
	[self addSubview:_pickerView];
	
	if(_selectedDate == nil){
		[self setDateSelected:[NSDate date]];
	}
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
	
	if(buttonIndex == 1){
		
		[_selectedDate release];
		_selectedDate = [[NSString stringWithFormat:DATE_PRINTF_FORMATTER, 
						  [_selectedDateComponents year],
						  [_selectedDateComponents month],
						  [_selectedDateComponents day],
						  [_selectedDateComponents hour],
						  [_selectedDateComponents minute],
                          [_selectedDateComponents second]] retain];
		
		if(self.delegate != nil && [self.delegate respondsToSelector:@selector(datePciker: didFinishedSelectDate:)]){
													  
			[self.delegate datePciker:self didFinishedSelectDate:_selectedDate];
		}
	}
	
	[super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

#pragma mark -
#pragma mark Getter/Setter methods.

- (void)setSelectedDate:(NSString *)date{
	
	[_selectedDate release];
	_selectedDate = [date retain];
	
	// Set the selected date be selected on |_pickerView|.
	[self setDateSelected:[self convertStringToDate:_selectedDate]];
}

#pragma mark -
#pragma mark Private methods.

- (void)setDateSelected:(NSDate *)date {
	
	_selectedDateComponents = [[[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|
						NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
													   fromDate:date] retain];
	[_pickerView selectRow:([_selectedDateComponents year] -2012)	inComponent:0 animated:NO];
	[_pickerView selectRow:([_selectedDateComponents month] -1)		inComponent:1 animated:NO];
	[_pickerView selectRow:([_selectedDateComponents day] -1)		inComponent:2 animated:NO];
	[_pickerView selectRow:([_selectedDateComponents hour]) 		inComponent:3 animated:NO];
	[_pickerView selectRow:([_selectedDateComponents minute])   	inComponent:4 animated:NO];
    [_pickerView selectRow:([_selectedDateComponents second])   	inComponent:5 animated:NO];
}

- (NSDate *)convertStringToDate:(NSString *)string {
	
	// Date Formatter.
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:DATE_FORMATTER];
	[formatter setTimeZone:[[NSCalendar currentCalendar] timeZone]];
	NSDate *temp = [formatter dateFromString:string];
	[formatter release];
	
	return temp;
}

- (void)dealloc {
	
	[_pickerView release];
	[_selectedDateComponents release];
	[_selectedDate release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark UIPickerViewDelegate Support.

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	switch (component) {
		case 0:
			[_selectedDateComponents setYear:2012 + row];
			break;
		case 1:
			[_selectedDateComponents setMonth:row + 1];
			break;
		case 2:
			if((row + 1) > days_in_month[leap_year([pickerView selectedRowInComponent:0] + 1)][[pickerView selectedRowInComponent:1] + 1]){
				
				[_selectedDateComponents setDay:1];
				[pickerView selectRow:0 inComponent:2 animated:YES];
			}
			else {
				[_selectedDateComponents setDay:row + 1];
			}

			break;
		case 3:
			[_selectedDateComponents setHour:row];
			break;
		case 4:
			[_selectedDateComponents setMinute:row];
			break;
		case 5:
			[_selectedDateComponents setSecond:row];
			break;
		default:
			break;
	}
}

#pragma mark -
#pragma mark UIPickerViewDataSource Support.

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	switch (component) {
		case 0:
			return [NSString stringWithFormat:@"%d", 2012 + row];
		case 3:
			return [NSString stringWithFormat:@"%02d", row];
		case 4:
			return [NSString stringWithFormat:@"%02d", row];
        case 5:
			return [NSString stringWithFormat:@"%02d", row];
		default:
			return [NSString stringWithFormat:@"%02d", row + 1];
	}
	
	return nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	switch (component) {
		case 0:
			return 58.0f;
		case 1:
			return 38.0f;
		case 2:
			return 38.0f;
		case 3:
			return 38.0f;
		case 4:
			return 38.0f;
        case 5:
			return 38.0f;
		default:
			break;
	}
	
	return 0.0f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	switch (component) {
		case 0:
			return 20;
		case 1:
			return 12;
		case 2:
			return 31;
		case 3:
			return 24;
		case 4:
			return 60;
        case 5:
			return 60;
		default:
			break;
	}
	
	return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 6;
}

@end
