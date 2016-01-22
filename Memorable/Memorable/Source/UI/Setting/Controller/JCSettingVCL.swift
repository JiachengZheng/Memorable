//
//  JCSettingVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/21.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingVCL: JCBaseTableViewVCL {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = JCSettingModel()
        loadItem()
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func loadItem(){
        let model = self.model as! JCSettingModel
        model.loadItem(nil , complete: { [weak self](com) -> Void in
            self?.reloadData()
            }) { (fail ) -> Void in
        }
    }
    
    func reloadData(){
        let model = self.model as! JCSettingModel
        dataSource = JCSettingDataSource(items:model.items)
        tableView.dataSource = self.dataSource
        tableView.reloadData()
    }
}

