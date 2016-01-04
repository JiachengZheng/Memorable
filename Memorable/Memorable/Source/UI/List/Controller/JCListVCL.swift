//
//  JCListVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListVCL: JCBaseTableViewVCL {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = JCListModel()
        loadItem()
        // Do any additional setup after loading the view.
    }
    
    func loadItem(){
        let model = self.model as! JCListModel
        model.loadItem(nil , complete: { [weak self](com) -> Void in
            self?.reloadData()
            }) { (fail ) -> Void in
                
        }
    }
    
    func reloadData(){
        let model = self.model as! JCListModel
        self.dataSource = JCListDataSource(items:model.items)
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
