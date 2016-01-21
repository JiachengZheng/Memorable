//
//  JCSettingVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/21.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingVCL: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
}

extension JCSettingVCL:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 13
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let row = indexPath.row
        
        let sectionCellArr = [0,4,6,10]
        let switchCellArr = [1,2,3,8]
        var identifier = ""
        
        if sectionCellArr.contains(row){
            identifier = "JCSettingSectionCell"
        }else if switchCellArr.contains(row){
            identifier = "JCSettingSwitchCell"
        }else{
            identifier = "JCSettingSelectCell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        if let cell1 = cell as? JCSettingSectionCell{
            cell1.configCell(indexPath)
        }
        if let cell1 = cell as? JCSettingSwitchCell{
            cell1.configCell(indexPath)
        }
        if let cell1 = cell as? JCSettingSelectCell{
            cell1.configCell(indexPath)
        }
        return cell

    }

}
