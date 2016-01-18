//
//  JCListVCL.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit
import pop
class JCListVCL: JCBaseTableViewVCL {
    var cellImageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startLaunchImage()
        self.navigationController?.delegate = self
        model = JCListModel()
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
    
    func startLaunchImage(){
        let launchVCL = loadViewController("JCLaunchVCL") as! JCLaunchVCL
        self.addChildViewController(launchVCL)
        self.view.addSubview(launchVCL.view)
        launchVCL.block = {
            launchVCL.view.layer.addSpringAnimation(kPOPLayerScaleXY,
                fromValue: NSValue.init(CGSize: CGSize(width: 1, height: 1)),
                toValue: NSValue.init(CGSize: CGSize(width: 1.4, height: 1.4)),
                bounds: 1,
                speed: 0.5,
                animKey: "scaleAnim"){ (pop, finish) -> Void in
                    launchVCL.view.removeFromSuperview()
                    launchVCL.removeFromParentViewController()
            }
            let opacityAnim = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
            opacityAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            opacityAnim.duration = 0.5
            opacityAnim.fromValue = 1
            opacityAnim.toValue = 0
            launchVCL.view.layer.pop_addAnimation(opacityAnim, forKey: "opacityAnim")
        }
        
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
        dataSource = JCListDataSource(items:model.items)
        tableView.dataSource = self.dataSource
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickDeleteBtn(indexPath: NSIndexPath){
        (model as! JCListModel).deleteItemAtIndex(indexPath)
        let dataSource = self.dataSource as! JCListDataSource
        dataSource.items.removeAtIndex(indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        tableView.endUpdates()
    }
    
    func clickTopBtn(indexPath: NSIndexPath){
        let item =  model.items[indexPath.row] as! JCListItem
        model.items.removeAtIndex(indexPath.row)
        model.items.insert(item, atIndex: 0)
        (model as! JCListModel).resetTopEvent()
        let dataSource = self.dataSource as! JCListDataSource
        dataSource.items.removeAtIndex(indexPath.row)
        dataSource.items.insert(item, atIndex: 0)
        tableView.beginUpdates()
        tableView.moveRowAtIndexPath(indexPath, toIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        tableView.endUpdates()

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
        let topAction = UITableViewRowAction(style: .Default, title: "置顶") {[unowned self]
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
             tableView.editing = false
             self.clickTopBtn(indexPath)
           
        }
        topAction.backgroundColor = UIColor.lightGrayColor()
        let deleteAction = UITableViewRowAction(style: .Default, title: "删除") {[unowned self]
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            tableView.editing = false
            self.clickDeleteBtn(indexPath)
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
