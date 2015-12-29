//
//  JCEventEditTableViewCell.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/26.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
import pop
let EditViewDisappearNotification = "EditViewDisappearNotification"



class JCEventEditTableViewCell: JCBaseTableViewCell {

    var nameTF: UITextField?
    var isTopSwitch: UISwitch?
    var dateLabel: UILabel?
    var timeLabel: UILabel?
    var typeLabel: UILabel?
    var arrowImage: UIImageView?
    
    override class func identifier() -> String {
        return "\(JCEventEditTableViewCell.self)"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = UIFont.systemFontOfSize(13)
        self.textLabel?.textColor = ColorSecondary()
        self.backgroundColor = UIColor.clearColor()
        let line = CALayer()
        line.frame = CGRect(x: 13, y: 43.5, width: screenWidth, height: 0.5)
        line.backgroundColor = UIColor.whiteColor().CGColor
        line.opacity = 0.2
        self.layer.addSublayer(line)
        self.selectionStyle = .None
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "editViewDidDisappear", name: EditViewDisappearNotification, object: nil)
    }
    
    override func setObject (obj: AnyObject?) {
        super.setObject(obj)
        guard let _ = obj,item = item as? JCEventEditViewItem else{
            return
        }
       
        textLabel?.text = item.itemType.description
        setupUI()
    }

    func setupUI(){
        guard let item = item as? JCEventEditViewItem else{
            return
        }
        switch item.itemType{
        case .Name:
            if let _ = nameTF{
            }else{
                nameTF = UITextField()
                nameTF?.placeholder = "事件名"
                nameTF?.font = UIFont.systemFontOfSize(14)
                nameTF?.adjustsFontSizeToFitWidth
                nameTF?.textAlignment = .Right
                nameTF?.textColor = ColorImportant()
                nameTF?.returnKeyType = .Done
                self.contentView.addSubview(nameTF!)
            }
            nameTF!.text = item.text
        case .Time:
            if let _ = timeLabel{
            }else{
                timeLabel = UILabel()
                timeLabel?.textAlignment = .Right
                timeLabel?.font = UIFont.systemFontOfSize(14)
                timeLabel?.textColor = ColorImportant()
                self.contentView.addSubview(timeLabel!)
            }
            timeLabel!.text = item.text
        case .Date:
            if let _ = dateLabel{
            }else{
                dateLabel = UILabel()
                dateLabel?.textAlignment = .Right
                dateLabel?.font = UIFont.systemFontOfSize(14)
                dateLabel?.textColor = ColorImportant()
                self.contentView.addSubview(dateLabel!)
            }
            dateLabel!.text = item.text
        case .Type:
            if let _ = typeLabel{
            }else{
                typeLabel = UILabel()
                typeLabel?.textAlignment = .Right
                typeLabel?.font = UIFont.systemFontOfSize(14)
                typeLabel?.textColor = ColorImportant()
                self.contentView.addSubview(typeLabel!)
            }
            if let _ = arrowImage{
            }else{
                arrowImage = UIImageView(image:UIImage(named: "edit_arrow"))
                self.contentView.addSubview(arrowImage!)
            }
            typeLabel!.text = item.text
        case .Top:
            if let _ = isTopSwitch{
            }else{
                isTopSwitch = UISwitch()
                
                self.contentView.addSubview(isTopSwitch!)
            }
            isTopSwitch?.on = item.isTop
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let item = item as? JCEventEditViewItem else{
            return
        }
        switch item.itemType{
        case .Name:
            nameTF!.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self).offset(-10)
                make.height.equalTo(45)
                make.width.equalTo(300)
            })
            
        case .Date:
            dateLabel!.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self).offset(-10)
                make.height.equalTo(45)
                make.width.equalTo(300)
            })
        case .Time:
            timeLabel!.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self).offset(-10)
                make.height.equalTo(45)
                make.width.equalTo(300)
            })

        case .Type:
            typeLabel!.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self).offset(-25)
                make.centerY.equalTo(self)
            })
            arrowImage!.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self).offset(-10)
                make.centerY.equalTo(self)
            })
        case .Top:
            isTopSwitch!.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self).offset(-10)
                make.centerY.equalTo(self)
            })

        }
        self.contentView.layoutIfNeeded()
    }
    
    func editViewDidDisappear(){
        nameTF?.resignFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
