//
//  JCEventCategoryVCL.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/29.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCEventCategoryVCL: JCBaseTableViewVCL {
    
    var currentCategory: String?
    var selectCategoryBlock:((String)-> Void)?
    
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
        var cate = ""
        if let currentCategory = currentCategory{
            cate = currentCategory
        }
        let dic:[String: AnyObject] = ["category": cate]
        model.loadItem(dic, complete: {[weak self] (com) -> Void in
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = self.model as! JCEventCategoryModel
        for item in model.items{
            let item1 = item as! JCEventCategoryItem
            item1.isSelected = false
        }
        let item = model.items[indexPath.row] as! JCEventCategoryItem
        item.isSelected = true
        reloadData()
        selectCategoryBlock?(item.text)
    }
    
    
    
}
