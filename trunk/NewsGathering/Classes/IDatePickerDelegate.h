/*
 *	File:		IDatePickerDelegate.h
 *	Contains:	The delegate of class DatePicker.
 *	Version:	1.0
 *	Author:		Qian Hui(hqian@cn.ufinity.com)
 *
 *  This source code is Copyright 2009 and owned by Ufinity Pte Ltd.
 *
 *	This source code is provided to SPH only for operations and maintenance of
 *	the contracted application. It cannot be re-distributed or revealed to a
 *	third party without the explicit consent of Ufinity.
 *
 *	Revision 1.0  2010/12/10 2:28:06  Qian Hui.
 *	Initial Checkin
 *
 */

#import <Foundation/Foundation.h>

@class DatePicker;

/*
 *	The protocol of MusicViewController.
 */
@protocol IDatePickerDelegate <UIAlertViewDelegate>

/*
 *	Notify the delegate when finished select date.
 *
 *	|selectedDate| is the selected date.
 */
- (void)datePciker:(DatePicker *)datePicker didFinishedSelectDate:(NSString *)selectedDate;

@end