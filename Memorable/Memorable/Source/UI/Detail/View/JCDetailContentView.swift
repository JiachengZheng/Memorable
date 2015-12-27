//
//  JCDetailContentView.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/25.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
import SnapKit
class JCDetailContentView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subDaysLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        subTitleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp_bottom)
        }
        daysLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            let spacing = getScaleValue(-20)
            make.centerY.equalTo(self.snp_centerY).offset(spacing)
        }
        subDaysLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(daysLabel.snp_right)
            make.baseline.equalTo(daysLabel.snp_baseline)
        }
        dateLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp_bottom)
        }

    }
}
