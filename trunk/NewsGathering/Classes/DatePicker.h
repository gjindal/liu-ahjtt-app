/*
 *	File:		DatePicker.h
 *	Contains:	The interface of class DatePicker.
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

#import <UIKit/UIKit.h>
#import "IDatePickerDelegate.h"

/*
 *	This interface be used to display the date(like year month day hour minute).
 */
@interface DatePicker : UIAlertView<UIPickerViewDelegate, UIPickerViewDataSource> {
@private
	UIPickerView			*_pickerView;				// The picker.
	NSString				*_selectedDate;				// The selected date.
	NSDateComponents		*_selectedDateComponents;	// The components of selected date.
}

@property (nonatomic, retain) NSString	*selectedDate;

@end
