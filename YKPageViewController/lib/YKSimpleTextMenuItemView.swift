//
//  YKSimpleTextMenuItemView.swift
//  YKPageViewController
//
//  Created by Yuta Kawabe on 2016/11/04.
//  Copyright © 2016年 Yuta Kawabe. All rights reserved.
//

import Foundation
import UIKit

class YKSimpleTextMenuItemView: YKPageViewControllerMenuItemView {
    
    var title: String? {
        get {
            return self.titleLabel.text
        }
        set(string) {
            self.titleLabel.text = string
            self.titleLabel.sizeToFit()
        }
    }
    
    var selectedTitleColor: UIColor? {
        get {
            return self.titleLabel.highlightedTextColor
        }
        set(color) {
            self.titleLabel.highlightedTextColor = color
        }
    }
    var normalTitleColor: UIColor? {
        get {
            return self.titleLabel.textColor
        }
        set(color) {
            self.titleLabel.textColor = color
        }
    }
    
    private var titleLabel: UILabel!
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func commonInit() {
        
        super.commonInit()
        
        self.titleLabel = UILabel()
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textColor = .lightGray
        self.titleLabel.highlightedTextColor = .orange
        self.addSubview(self.titleLabel)
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func didSelect() {
        self.titleLabel.isHighlighted = true
    }
    
    override func didDeselect() {
        self.titleLabel.isHighlighted = false
    }
}
