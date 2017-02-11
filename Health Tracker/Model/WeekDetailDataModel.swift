//
//  WeekDetailDataModel.swift
//  Health Tracker
//
//  Created by Thirumal on 11/02/17.
//  Copyright © 2017 Think42labs. All rights reserved.
//

import Foundation

struct WeekDetailDataModel
{
    let weekStartDate : Date!
    let dateDetailList : [DateDetailDataModel]!
}

struct DateDetailDataModel
{
    let date : Date!
    let numberOfSteps : Int!
    let hourStepList : [HourDetail]!
}

struct HourDetail
{
    let periodId : Int!
    let numberOfSteps : Int!
}
