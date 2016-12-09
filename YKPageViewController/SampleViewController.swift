//
//  SampleViewController.swift
//  YKPageViewController
//
//  Created by Yuta Kawabe on 2016/11/04.
//  Copyright © 2016年 Yuta Kawabe. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moveToOriginal(_ sender: UIButton) {
        
        let vc = YKPageViewController()
        
        // ページ情報
        vc.pageInfoList = [
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .red
                view.title = "1"
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .red
                let body = UILabel()
                body.text = "アユム"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .green
                view.title = "2"
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .green
                let body = UILabel()
                body.text = "ムッツリ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .blue
                view.title = "3"
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .blue
                let body = UILabel()
                body.text = "リカ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .yellow
                view.title = "4"
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .yellow
                let body = UILabel()
                body.text = "カナリア"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
        ]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func moveToScroll(_ sender: UIButton) {
        
        let vc = YKPageViewController()
        vc.menuViewMode = .Scroll
        vc.menuItemViewWidth = 120.0
        
        // ページ情報
        vc.pageInfoList = [
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .red
                view.title = "1"
                view.selectedTitleColor = .white
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .red
                let body = UILabel()
                body.text = "ヨウスケ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .green
                view.title = "2"
                view.selectedTitleColor = .white
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .green
                let body = UILabel()
                body.text = "ケイタ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .blue
                view.title = "3"
                view.selectedTitleColor = .white
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .blue
                let body = UILabel()
                body.text = "タケシ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .yellow
                view.title = "4"
                view.selectedTitleColor = .white
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .yellow
                let body = UILabel()
                body.text = "シキ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .red
                view.title = "5"
                view.selectedTitleColor = .white
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .red
                let body = UILabel()
                body.text = "キミマロ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .green
                view.title = "6"
                view.selectedTitleColor = .white
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .green
                let body = UILabel()
                body.text = "ロッカ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .blue
                view.title = "7"
                view.selectedTitleColor = .white
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .blue
                let body = UILabel()
                body.text = "カイ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
            {
                let view = YKSimpleTextMenuItemView()
                view.backgroundColor = .yellow
                view.title = "8"
                view.selectedTitleColor = .white
                view.parent = vc
                let vc = UIViewController()
                vc.view.backgroundColor = .yellow
                let body = UILabel()
                body.text = "イヨ"
                body.sizeToFit()
                body.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
                body.center = vc.view.center
                vc.view.addSubview(body)
                return YKPageViewController.PageInfo(menuItemView: view, vc: vc)
            }(),
        ]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func moveToCustom(_ sender: UIButton) {
        
        let vc = CustomYKPageViewController(nibName: "YKPageViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
