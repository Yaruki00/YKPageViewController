//
//  CustomYKPageViewController.swift
//  YKPageViewController
//
//  Created by Yuta Kawabe on 2016/11/04.
//  Copyright © 2016年 Yuta Kawabe. All rights reserved.
//

import Foundation
import UIKit

class CustomYKPageViewController: YKPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ページ情報
        self.pageInfoList = [
            {
                let view = YKSimpleTextMenuItemView()
                //view.backgroundColor = .red
                view.title = "1"
                view.selectedTitleColor = .blue
                view.parent = self
                let vc = UIViewController()
                vc.view.backgroundColor = .red
                let body = UILabel()
                body.text = "ユウタ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                //view.backgroundColor = .green
                view.title = "2"
                view.selectedTitleColor = .blue
                view.parent = self
                let vc = UIViewController()
                vc.view.backgroundColor = .green
                let body = UILabel()
                body.text = "タロウ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                //view.backgroundColor = .blue
                view.title = "3"
                view.selectedTitleColor = .blue
                view.parent = self
                let vc = UIViewController()
                vc.view.backgroundColor = .blue
                let body = UILabel()
                body.text = "ウリア"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                //view.backgroundColor = .yellow
                view.title = "4"
                view.selectedTitleColor = .blue
                view.parent = self
                let vc = UIViewController()
                vc.view.backgroundColor = .yellow
                let body = UILabel()
                body.text = "アユ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return PageInfo(menuItemView: view, vc: vc)
            }(),
        ]
        
        let designView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        designView.backgroundColor = .orange
        designView.layer.cornerRadius = 5
        designView.center = self.menuBackgroundView.center
        self.menuBackgroundDesignView = designView
        self.menuBackgroundView.addSubview(designView)
        
        // ページ準備
        self.setupPageList()
    }
}
