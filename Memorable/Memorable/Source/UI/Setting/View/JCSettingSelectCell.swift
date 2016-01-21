//
//  JCSettingSelectCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/21.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingSelectCell: UITableViewCell {
    @IBOutlet weak var rightTitle: UILabel!

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
        if row == 5{
            title.text = "排序方式"
            rightTitle.text = "按时间排序"
        }else if row == 7 {
            title.text = "显示事件数量"
            rightTitle.text = "3"
        }else if row == 9 {
            title.text = "显示分类"
            rightTitle.text = "生活"
        }else if row == 11 {
            title.text = "备份到iCloud"
            rightTitle.text = ""
        }else if row == 12 {
            title.text = "从iCloud恢复"
            rightTitle.text = ""
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        rightTitle.text = ""
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
