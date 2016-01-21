//
//  JCSettingSectionCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/21.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingSectionCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(index: NSIndexPath){
        let row = index.row
        if row == 0{
            title.text = "提醒"
        }else if row == 4 {
            title.text = "排序"
        }else if row == 6 {
            title.text = "通知中心插件"
        }else if row == 10 {
            title.text = "iCloud"
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
