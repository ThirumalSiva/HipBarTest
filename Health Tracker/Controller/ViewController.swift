//
//  ViewController.swift
//  Health Tracker
//
//  Created by Thirumal on 11/02/17.
//  Copyright © 2017 Think42labs. All rights reserved.
//

import UIKit

struct CollectionViewTag
{
    static let TapCollectionView : Int = 100
    static let DetailCollectionView : Int = 101
}

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{

    //MARK:- Variables
    //MARK:-- Outlet
    @IBOutlet weak var weekDetailCollectionView: UICollectionView!
    @IBOutlet weak var tabCollectionView: UICollectionView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    //MARK:-- Class
    
    
    var weekDetail : WeekDetailDataModel!
    var collectionViewDataList : [TabCollectionViewCellDataModel] = []
    var currentSelectedTabIndex : Int = 0
    
    //MARK:- View life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setShareButtonUI()
        
        self.weekDetail = WeekDetailDataBL.shared.getWeekDetail()
        self.collectionViewDataList = WeekDetailDataBL.shared.getDataListForTabCollectionViewCell()
    }
    
    override func viewDidLayoutSubviews()
    {
        self.tabCollectionView.reloadData()
        self.weekDetailCollectionView.reloadData()
        self.setCurrentWeekDetail()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- CollectionViewDelegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return collectionViewDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if CollectionViewTag.TapCollectionView == collectionView.tag
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CollectionViewCellIdentifier.TabCollectionViewCell, for: indexPath) as! TabCollectionViewCell
            
            cell.setCollectionViewDetail(cellDetail: collectionViewDataList[indexPath.item])
            
            cell.setCellSelected(selected : currentSelectedTabIndex == indexPath.item)
            
            return cell
        }
        else
        {
            if indexPath.item == 0
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CollectionViewCellIdentifier.WeekDetailCollectionViewCell, for: indexPath) as! WeekDetailCollectionViewCell
                cell.dateDetailList = self.weekDetail.dateDetailList
                cell.addHexagonalView()
                
                return cell
                
            }
            else
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CollectionViewCellIdentifier.WeekGraphCollectionViewCell, for: indexPath) as! WeekGraphCollectionViewCell
                cell.dateDetailList = self.weekDetail.dateDetailList
                cell.graphTableView.reloadData()
                cell.collectionView.reloadData()
                
                return cell
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if CollectionViewTag.TapCollectionView == collectionView.tag
        {
            self.currentSelectedTabIndex = indexPath.item
            self.setCurrentWeekDetail()
            self.tabCollectionView.reloadData()
        }
    }
    
    //MARK:- CollectionView flow layout delegete
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if CollectionViewTag.TapCollectionView == collectionView.tag
        {
            return CGSize(width: (self.view.frame.width / 3.5 ), height: collectionView.frame.size.height)
        }
        else
        {
            return collectionView.frame.size
        }
    }
        
    //MARK:- Private functions
    
    private func setShareButtonUI()
    {
        self.shareButton.layer.cornerRadius = 5.0
        self.shareButton.layer.borderColor = Constant.Color.ShareButtonBorder.cgColor
        self.shareButton.layer.borderWidth = 2.0
    }
    
    private func setCurrentWeekDetail()
    {
        self.weekDetailCollectionView.scrollToItem(at: IndexPath(item: self.currentSelectedTabIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
}

