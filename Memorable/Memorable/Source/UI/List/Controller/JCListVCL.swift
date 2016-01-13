//
//  JCListVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListVCL: JCBaseTableViewVCL {
    var cellImageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.model = JCListModel()
        loadItem()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
        loadItem()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func loadItem(){
        if let cellImageView = cellImageView{
            cellImageView.removeFromSuperview()
        }
        
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
}

//MARK: UITableViewDelegate
extension JCListVCL{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! JCListTableViewCell
        cellImageView = cell.bgImageView.snapshotViewAfterScreenUpdates(false)
        self.view.addSubview(cellImageView)
        cellImageView.frame = CGRectMake(0, CGFloat(64 + listCellHight * CGFloat(indexPath.row)), screenWidth, listCellHight)
        let item = self.model.items[indexPath.row] as! JCListItem
        let event = item.event
        let vcl = loadViewController("JCEventDetailVCL") as! JCEventDetailVCL
        vcl.paramDic = ["fromList": true,"event":event]
        self.navigationController?.pushViewController(vcl, animated: true)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?{
        let topAction = UITableViewRowAction(style: .Default, title: "置顶") {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            tableView.editing = false
        }
        topAction.backgroundColor = UIColor.lightGrayColor()
        let deleteAction = UITableViewRowAction(style: .Default, title: "删除") {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            tableView.editing = false
        }
        deleteAction.backgroundColor = UIColor.redColor()
        return [deleteAction,topAction]
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
}

extension JCListVCL: UINavigationControllerDelegate{
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
         if let _ = toVC as? JCEventDetailVCL{
            if operation == UINavigationControllerOperation.Push {
                return JCListToDetailTransion()
            } else {
                return nil
            }
        }
        return nil
    }
}
