//
//  JCSettingSwitchCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/21.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingSwitchCell: UITableViewCell {
    @IBOutlet weak var swithBtn: UISwitch!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let layer = CALayer()
        layer.backgroundColor = ColorSeparator().CGColor
        self.contentView.layer.addSublayer(layer)
        layer.frame = CGRectMake(8, 43.5, screenWidth, 0.5)
        // Initialization code
    }
    
    func configCell(index: NSIndexPath){
        let row = index.row
        if row == 1{
            title.text = "开启通知"
            swithBtn.on = false
        }else if row == 2 {
            title.text = "图标数字"
            swithBtn.on = true
        }else if row == 3 {
            title.text = "置顶事件每日提醒"
            swithBtn.on = true
        }else if row == 4 {
            title.text = "日历"
            swithBtn.on = false
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        swithBtn.on = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
