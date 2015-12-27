//
//  JCDetailEditView.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/26.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

let editViewHeight: CGFloat = 270
let editViewExtentHeight: CGFloat = 60

protocol JCDetailEditViewDelegate: NSObjectProtocol{
    func didClickCancelBtn()
    func didClickSaveBtn()
}

class JCDetailEditView: UIVisualEffectView {

    weak var delegate: JCDetailEditViewDelegate?
    var tableView: UITableView!
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        self.initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        let cancelBtn = UIButton(type: .System)
        cancelBtn.setTitle("取消", forState: .Normal)
        cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(cancelBtn)
        cancelBtn.titleEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: 0, right: 0)
        cancelBtn.addTarget(self, action: "clickCancelBtn", forControlEvents: .TouchUpInside)
        cancelBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.size.equalTo(CGSize(width: 60, height: 44))
            make.top.equalTo(self.snp_top).offset(20+editViewExtentHeight/2)
        }
        
        let saveBtn = UIButton(type: .System)
        saveBtn.setTitle("保存", forState: .Normal)
        saveBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(saveBtn)
        saveBtn.titleEdgeInsets = UIEdgeInsets(top: -10, left: 10, bottom: 0, right: 0)
        saveBtn.addTarget(self, action: "clickSaveBtn", forControlEvents: .TouchUpInside)
        saveBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self)
            make.size.equalTo(CGSize(width: 60, height: 44))
            make.top.equalTo(self.snp_top).offset(20+editViewExtentHeight/2)
        }
        
        let title = UILabel()
        title.font = UIFont.systemFontOfSize(17)
        self.contentView.addSubview(title)
        title.textColor = ColorImportant()
        title.text = "编辑"
        title.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(saveBtn).offset(-5)
            make.centerX.equalTo(self)
            make.height.equalTo(self)
        }
        
        tableView = UITableView()
        self.contentView.addSubview(tableView)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.top.equalTo(cancelBtn.snp_bottom).offset(-5)
            make.size.equalTo(CGSize(width: screenWidth, height: 225))
        }
        tableView.separatorStyle = .None
        
        let line = CALayer()
        line.frame = CGRectMake(0, 88, screenWidth, 0.5)
        line.backgroundColor = UIColor.colorWithHex(0xc0c0c0).CGColor
        line.opacity = 0.5
        self.layer.addSublayer(line)
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRectMake((screenWidth - 25)/2, editViewHeight + editViewExtentHeight - 10, 25, 3)
        bottomLine.cornerRadius = 2
        bottomLine.backgroundColor = UIColor.whiteColor().CGColor//UIColor.colorWithHex(0xa8a8a8).CGColor
        self.layer.addSublayer(bottomLine)
    }
    
    func clickCancelBtn(){
        self.delegate?.didClickCancelBtn()
    }
    
    func clickSaveBtn(){
        self.delegate?.didClickSaveBtn()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
