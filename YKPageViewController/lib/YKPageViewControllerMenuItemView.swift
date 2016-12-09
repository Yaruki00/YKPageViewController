//
//  YKPageViewControllerMenuItemView.swift
//  YKPageViewController
//
//  Created by Yuta Kawabe on 2016/11/24.
//  Copyright © 2016年 Yuta Kawabe. All rights reserved.
//

import Foundation
import UIKit

// このクラスを直接使わないこと！
// 継承したクラスを使ってね
class YKPageViewControllerMenuItemView: UIView, YKPageViewControllerMenuItemViewDelegate {
    
    var parent: YKPageViewController!
    var tapRecognizer: UITapGestureRecognizer!
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(YKPageViewControllerMenuItemView.tellTapEventToParent))
        self.addGestureRecognizer(self.tapRecognizer)
    }
    
    func didSelect() {}
    func didDeselect() {}
    
    func tellTapEventToParent() {
        parent.menuDidSelectByTap(index: self.tag)
    }
}
