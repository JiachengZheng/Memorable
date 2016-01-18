//
//  JCLaunchVCL.swift
//  Memorable
//
//  Created by zhengjiacheng on 16/1/18.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCLaunchVCL: JCBaseVCL {

    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bottomImage: UIImageView!
    var block: (()->Void)?
    
    @IBOutlet weak var smileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = NSDate().formattedDateWithStyle(.FullStyle, locale: NSLocale.currentLocale())
        bottomImage.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp_bottom).offset(-25.5)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSizeMake(200, 41.5))
        }
        smileImage.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.view).offset(-40)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSizeMake(73, 92))
        }
        dateLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(smileImage.snp_bottom).offset(20)
        }
        subTitle.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(dateLabel.snp_bottom).offset(10)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        performSelector("dissmiss", withObject: nil, afterDelay: 2.5)
    }
    
    func dissmiss(){
        block?()
    }
    
}
