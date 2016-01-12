//
//  JCListTableViewCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit
import pop
let listCellHight:CGFloat = 70

class JCListTableViewCell: JCBaseTableViewCell {

    @IBOutlet weak var daysLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    override class func identifier() -> String {
        return "\(JCListTableViewCell.self)"
    }
    @IBOutlet weak var bgImageView: UIImageView!
    
    override class func tableView(tableView: UITableView, rowHeightForObject object: AnyObject) -> CGFloat {
        return listCellHight
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let line = CALayer()
        line.frame = CGRectMake(0, self.height - 0.5, screenWidth, 0.5)
        self.layer.addSublayer(line)
        line.backgroundColor = ColorSeparator().CGColor
    }
    
    override func setObject (obj: AnyObject?) {
        super.setObject(obj)
        guard let object = obj as? JCListItem else{
            return
        }
        nameLable.text = object.name
        if let date = object.date{
            dateLabel.text = date
            if date.hasSuffix("00:00") || date.hasSuffix("24:00"){
                dateLabel.text = date[0...9]
            }
            daysLable.text = intervalTimeFromDate(date,formatter: "yyyy-MM-dd HH:mm").0
            bgImageView.loadLocalImage("cell_bg_\(object.event.bgName[10...10])")
        }
    }
    
    //抖动效果，被李佳琪否决了
    func toggleAnimation(){
        
        let anim = POPBasicAnimation(propertyNamed: kPOPLayerPosition)
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        anim.duration = 0.1
        anim.repeatCount = 4
        anim.fromValue = NSValue.init(CGPoint: CGPoint(x: screenWidth/2 - 1, y: self.center.y))
        anim.toValue = NSValue.init(CGPoint: CGPoint(x: screenWidth/2 + 1, y: self.center.y))
        self.layer.pop_addAnimation(anim, forKey: "opacityAnim")
    }
    
    override func prepareForReuse() {
        nameLable.text = ""
        dateLabel.text = ""
        daysLable.text = ""
        bgImageView.image = nil
    }


}
