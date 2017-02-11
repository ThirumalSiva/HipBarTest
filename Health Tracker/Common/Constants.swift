//
//  Constants.swift
//  Health Tracker
//
//  Created by Thirumal on 11/02/17.
//  Copyright © 2017 Think42labs. All rights reserved.
//

import Foundation
import UIKit

struct Constant
{
    struct Color
    {
        static let ShareButtonBorder = UIColor(red: 60.0/255.0, green: 150.0/255.0, blue: 192.0/255.0, alpha: 1.0)
        static let TabCollectionCellSelected = UIColor(red: 37.0/255.0, green: 59.0/255.0, blue: 86.0/255.0, alpha: 1.0)
    }
    
    struct CollectionViewCellIdentifier
    {
        static let TabCollectionViewCell : String = "tabCollectionViewCell"
        static let WeekDetailCollectionViewCell : String = "weekDetailCollectionViewCell"
        static let WeekGraphCollectionViewCell : String = "weekGraphCollectionViewCell"
        static let HourCollectionViewCell : String = "hourCollectionViewCell"
        static let GraphCollectionViewCell : String = "graphCollectionViewCell"
    }
    
    struct TableViewCellIdentifier
    {
        static let WeekGraphTableViewCell : String = "weekGraphTableViewCell"
    }
    
}
