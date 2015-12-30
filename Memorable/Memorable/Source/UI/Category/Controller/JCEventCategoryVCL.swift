//
//  JCEventCategoryVCL.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/29.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCEventCategoryVCL: JCBaseTableViewVCL {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = JCEventCategoryModel()
        loadItem()
        addLine()
    }
    
    func addLine(){
        let line = CALayer()
        line.backgroundColor = UIColor.whiteColor().CGColor
        line.frame = CGRectMake(0, 64, screenWidth, 0.5)
        line.opacity = 0.5
        self.view.layer.addSublayer(line)
    }
    
    func loadItem(){
        let model = self.model as! JCEventCategoryModel
        model.loadItem(nil, complete: {[weak self] (com) -> Void in
            self?.reloadData()
            }) { (fail) -> Void in
        }
    }
    
    func reloadData(){
        let model = self.model as! JCEventCategoryModel
        self.dataSource = JCEventCategoryDataSource(items:model.items)
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
