//
//  JCListTableViewCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListTableViewCell: JCBaseTableViewCell {

    @IBOutlet weak var daysLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    override class func identifier() -> String {
        return "\(JCListTableViewCell.self)"
    }
    @IBOutlet weak var bgImageView: UIImageView!
    
    override class func tableView(tableView: UITableView, rowHeightForObject object: AnyObject) -> CGFloat {
        return 70
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
            daysLable.text = intervalTimeFromDate(date,formatter: "yyyy-MM-dd").0
            if let d = strToDate(date,formatter: "yyyy-MM-dd"){
                if d.isEarlierThan(NSDate()){
                    bgImageView.image = UIImage(named: "cell_bg1")
                }else{
                    bgImageView.image = UIImage(named: "cell_bg2")
                }
            }
            
        }
        
    }
    
    override func prepareForReuse() {
        nameLable.text = ""
        dateLabel.text = ""
        daysLable.text = ""
        bgImageView.image = nil
    }


}
