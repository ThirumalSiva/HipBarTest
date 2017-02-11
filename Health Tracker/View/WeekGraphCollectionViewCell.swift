//
//  WeekGraphCollectionViewCell.swift
//  Health Tracker
//
//  Created by Thirumal on 11/02/17.
//  Copyright © 2017 Think42labs. All rights reserved.
//

import UIKit

class WeekGraphCollectionViewCell: UICollectionViewCell , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var graphTableView: UITableView!
    var hourList : [String] = ["12","2","4","6","8","10","12","2","4","6","8","10"]

    var dateDetailList : [DateDetailDataModel] = []
    //MARK:- CollectionView Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return hourList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CollectionViewCellIdentifier.HourCollectionViewCell, for: indexPath) as! HourCollectionViewCell
        cell.timeLabel.text = hourList[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width / 12, height: collectionView.frame.size.height)
    }
    
    //MARK:- Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dateDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.TableViewCellIdentifier.WeekGraphTableViewCell, for: indexPath) as! WeekGraphTableViewCell
        cell.setDateDetail(dateDetail: dateDetailList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return tableView.frame.height / CGFloat(dateDetailList.count)
    }

}
