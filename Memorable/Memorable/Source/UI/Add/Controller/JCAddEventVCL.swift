//
//  JCAddEventVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/23.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCAddEventVCL: JCBaseTableViewVCL {

    override func viewDidLoad() {
        super.viewDidLoad()
        model = JCAddEventModel()
        loadItem()
    }
    
    func loadItem(){
        let model = self.model as! JCAddEventModel
        model.loadItem(nil , complete: { [weak self](com) -> Void in
            self?.reloadData()
            }) { (fail ) -> Void in
        }
    }
    
    func reloadData(){
        let model = self.model as! JCAddEventModel
        dataSource = JCAddEventDataSource(items:model.items)
        tableView.dataSource = self.dataSource
        tableView.reloadData()
    }


}
