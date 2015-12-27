//
//  JCDetailEditTableViewCell.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/26.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

let EditViewDisappearNotification = "EditViewDisappearNotification"

enum EditTableViewCellType: Int{
    case Name,Date,Time,Type,Top
    var description: String {
        switch self{
            case .Name: return "事件名"
            case .Date: return "日期"
            case .Time: return "时间"
            case .Type: return "分类"
            case .Top: return "置顶"
        }
    }

}

class JCDetailEditTableViewCell: UITableViewCell {

    var nameTF: UITextField?
    var type: EditTableViewCellType?
    var isTopSwitch: UISwitch?
    var isTop: Bool = false
    var dateLabel: UILabel?
    var timeLabel: UILabel?
    var typeLabel: UILabel?
    var arrowImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
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
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?,type: EditTableViewCellType){
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.type = type
        self.textLabel?.text = type.description
        self.initUI(type)
    }

    func initUI(type: EditTableViewCellType){
        switch type{
        case .Name:
            if let _ = nameTF{
            }else{
                nameTF = UITextField()
                nameTF?.placeholder = "事件名"
                nameTF?.font = UIFont.systemFontOfSize(13)
                nameTF?.adjustsFontSizeToFitWidth
                nameTF?.textAlignment = .Right
                nameTF?.textColor = ColorImportant()
                nameTF?.returnKeyType = .Done
                self.contentView.addSubview(nameTF!)
            }
        case .Time:
            if let _ = timeLabel{
            }else{
                timeLabel = UILabel()
                timeLabel!.text = "00:00"
                timeLabel?.textAlignment = .Right
                timeLabel?.font = UIFont.systemFontOfSize(13)
                timeLabel?.textColor = ColorImportant()
                self.contentView.addSubview(timeLabel!)
            }

        case .Date:
            if let _ = dateLabel{
            }else{
                dateLabel = UILabel()
                dateLabel!.text = "2015,12月25 周四"
                dateLabel?.textAlignment = .Right
                dateLabel?.font = UIFont.systemFontOfSize(13)
                dateLabel?.textColor = ColorImportant()
                self.contentView.addSubview(dateLabel!)
            }
            
        case .Type:
            if let _ = typeLabel{
            }else{
                typeLabel = UILabel()
                typeLabel!.text = "分类"
                typeLabel?.textAlignment = .Right
                typeLabel?.font = UIFont.systemFontOfSize(13)
                typeLabel?.textColor = ColorImportant()
                self.contentView.addSubview(typeLabel!)
            }
            if let _ = arrowImage{
            }else{
                arrowImage = UIImageView(image:UIImage(named: "edit_arrow"))
                self.contentView.addSubview(arrowImage!)
            }
            
        case .Top:
            if let _ = isTopSwitch{
            }else{
                isTopSwitch = UISwitch()
                isTopSwitch?.on = isTop
                self.contentView.addSubview(isTopSwitch!)
            }
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type!{
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
                make.right.equalTo(self).offset(-20)
                make.centerY.equalTo(self)
            })
            arrowImage!.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self).offset(-5)
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
