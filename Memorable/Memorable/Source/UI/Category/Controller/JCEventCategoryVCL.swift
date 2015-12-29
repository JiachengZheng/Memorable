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
        if let items = model.items{
            self.tableView.dataSource = JCEventEditViewDataSource(items:items)
            self.tableView.reloadData()
        }
    }
}
