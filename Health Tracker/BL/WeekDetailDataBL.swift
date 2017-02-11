//
//  WeekDetailDataBL.swift
//  Health Tracker
//
//  Created by Thirumal on 11/02/17.
//  Copyright © 2017 Think42labs. All rights reserved.
//

import UIKit

class WeekDetailDataBL: NSObject
{
    //MARK:- Class function
    
    public class var shared: WeekDetailDataBL
    {
        struct Static
        {
            static let instance: WeekDetailDataBL = WeekDetailDataBL()
        }
        return Static.instance
    }
    
    func getDataListForTabCollectionViewCell() ->[TabCollectionViewCellDataModel]
    {
        var tabCollectionCellDataList : [TabCollectionViewCellDataModel] = []
        
        for index : Int in 0 ..< 2
        {
            tabCollectionCellDataList.append(TabCollectionViewCellDataModel(imageName: ["image1","image2","image3"][index], titleText: ["Week","Steps","MindMap"][index], subTitleText: ["The week of June 6","Average 1,790 steps per day","Daily patterns of work & play"][index]))
        }
        return tabCollectionCellDataList
    }
    
    func getWeekDetail() -> WeekDetailDataModel
    {
        let startDate = self.getStartDateOfWeek()
        let dateDetailList = self.getDateDetailList(currentWeekStartDate: startDate)
        
        return WeekDetailDataModel(weekStartDate: startDate, dateDetailList: dateDetailList)
    }
    
    func getDateDetailList(currentWeekStartDate : Date) -> [DateDetailDataModel]
    {
        var dateList : [DateDetailDataModel] = []
        
        for index : Int in 0 ..< 7
        {
           let addedDate =  self.gregorian.date(byAdding: Calendar.Component.day, value: index, to: currentWeekStartDate)!
            
            let totalStep = index * 250
            
            var hourStepDetail : [HourDetail] = []
            for periodId : Int in 0 ..< 48
            {
                hourStepDetail.append(HourDetail(periodId: periodId, numberOfSteps: Int((totalStep * periodId) / 48 )))
            }
            
            dateList.append(DateDetailDataModel(date: addedDate, numberOfSteps: totalStep, hourStepList: hourStepDetail))
        }
        return dateList
    }
    
    lazy var gregorian : Calendar =
        {
            var cal = Calendar(identifier: Calendar.Identifier.gregorian)
            cal.timeZone = TimeZone(secondsFromGMT: 0)!
            
            return cal
    }()
    
    func getCurrentDate() -> Date
    {
        let defaultDate = Date()
        let components = self.gregorian.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: defaultDate)
        
        if let currentDate = self.gregorian.date(from: components)
        {
            return currentDate
        }
        return defaultDate
    }
    
    func getStartDateOfWeek() -> Date
    {
        let currentDate = getCurrentDate()
        let firstDayOfWeek = self.gregorian.dateComponents( [.weekday], from: currentDate).weekday!
         let date = self.gregorian.date(byAdding: Calendar.Component.day, value: ((firstDayOfWeek * -1) + 2), to: currentDate)
        return date!
    }
    
    func getDisplayDate(date : Date) -> NSAttributedString
    {
        let components = self.gregorian.dateComponents([Calendar.Component.day], from: date)
        let dateFormat :  DateFormatter = DateFormatter()
        dateFormat.dateFormat = "EEE"
        
        let attributedString = NSMutableAttributedString(string:dateFormat.string(from: date).uppercased() + "\n" , attributes: [NSForegroundColorAttributeName: UIColor.white , NSFontAttributeName: UIFont.systemFont(ofSize: 10)])
        
        attributedString.append(NSAttributedString(string:"\(components.day!)" , attributes: [NSForegroundColorAttributeName: UIColor.white , NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]))
        
        return attributedString
    }
    
}
