//
//  YKPageViewController.swift
//  YKPageViewController
//
//  Created by Yuta Kawabe on 2016/11/04.
//  Copyright © 2016年 Yuta Kawabe. All rights reserved.
//

import Foundation
import UIKit

protocol YKPageViewControllerMenuItemViewDelegate {
    var parent: YKPageViewController! { set get }
    func didSelect()
    func didDeselect()
}

// 本体
class YKPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    struct PageInfo {
        var menuItemView: YKPageViewControllerMenuItemView
        var vc: UIViewController
    }
    
    enum MenuViewMode {
        case SinglePage
        case Scroll
    }
    
    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuBackgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var pageInfoList: [PageInfo] = []
    var currentPageIndex = 0
    var menuViewMode = MenuViewMode.SinglePage
    var menuItemViewWidth: CGFloat?
    var menuBackgroundDesignView: UIView?
    var shouldIgnoreScrollDelegate = false
    
    private var pageViewController: UIPageViewController!
    private var menuScrollOffsetXList: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 勝手なスクロール調節させない
        self.automaticallyAdjustsScrollViewInsets = false
        
        if let designView = self.menuBackgroundDesignView {
            self.menuBackgroundView.addSubview(designView)
        }
        
        // ページビューコントローラ準備
        self.setupPageViewController()
        
        // ページ準備
        self.setupPageList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        self.menuBackgroundView.frame.size.width = self.view.frame.width / CGFloat(self.pageInfoList.count)
        if let designView = self.menuBackgroundDesignView {
            designView.center = self.menuBackgroundView.center
        }
    }
    
    // ページビューコントローラもろもろ
    private func setupPageViewController() {
        
        // 生成
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        // 親にセット
        self.pageViewController.view.frame.size = self.contentView.frame.size
        self.addChildViewController(self.pageViewController)
        self.contentView.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        // デリゲート
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        for view in self.pageViewController.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
        
        // ジェスチャー
        self.contentView.gestureRecognizers = self.pageViewController.gestureRecognizers
    }
    
    // ページもろもろ
    func setupPageList() {
        
        // メニューがスクロールモードの場合は幅制約をつけ直す
        switch self.menuViewMode {
        case .Scroll:
            
            if let fixWidth = self.menuItemViewWidth {
                self.menuScrollView.removeConstraint(self.menuViewWidthConstraint)
                self.menuView.addConstraint(NSLayoutConstraint(
                    item       : self.menuView,
                    attribute  : .width,
                    relatedBy  : .equal,
                    toItem     : nil,
                    attribute  : .width,
                    multiplier : 1.0,
                    constant   : fixWidth * CGFloat(self.pageInfoList.count)
                ))
            }
            else {
                print("warn: menuViewMode is .Scroll but menuItemViewWidth has no value")
            }
            break
            
        default:
            break
        }
        
        // メニュー作る
        var constraintsString = "|"
        var menuItemViewList: [String: UIView] = [:]
        for i in 0..<self.pageInfoList.count {
            
            let menuItemView = self.pageInfoList[i].menuItemView
            menuItemView.translatesAutoresizingMaskIntoConstraints = false
            self.menuView.addSubview(menuItemView)
            
            // 高さ制約
            self.menuView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat : "V:|[view]|",
                options          : [],
                metrics          : nil,
                views            : ["view": menuItemView]
            ))
            
            // 幅制約
            menuItemViewList["view\(i)"] = menuItemView
            constraintsString += "[view\(i)]"
            self.menuView.addConstraint(NSLayoutConstraint(
                item       : menuItemView,
                attribute  : .width,
                relatedBy  : .equal,
                toItem     : self.menuView,
                attribute  : .width,
                multiplier : 1.0 / CGFloat(self.pageInfoList.count),
                constant   : 0
            ))
            
            // メニューのスクロール位置
            if self.menuViewMode == .Scroll, let fixWidth = self.menuItemViewWidth {
                var offsetX = (CGFloat(i) + 0.5) * fixWidth - 0.5 * UIScreen.main.bounds.width
                offsetX = max(0, offsetX)
                offsetX = min(fixWidth * CGFloat(self.pageInfoList.count) - UIScreen.main.bounds.width, offsetX)
                self.menuScrollOffsetXList.append(offsetX)
            }
            
            // タグのセットしておく
            self.pageInfoList[i].vc.view.tag = i + 1
            self.pageInfoList[i].menuItemView.tag = i + 1
        }
        
        // 中身があれば
        if self.pageInfoList.count > 0 {
            
            // 幅制約続き
            constraintsString += "|"
            self.menuView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat : constraintsString,
                options          : [],
                metrics          : nil,
                views            : menuItemViewList
            ))
            
            // 最初のページをセット
            self.pageViewController.setViewControllers([self.pageInfoList[self.currentPageIndex].vc], direction: .forward, animated: false, completion: nil)
            self.pageInfoList[self.currentPageIndex].menuItemView.didSelect()
        }
    }
    
    // 左隣のページ取得
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = viewController.view.tag - 1
        
        index -= 1
        if index < 0 {
            index = self.pageInfoList.count - 1
        }
        return self.pageInfoList[index].vc
    }
    
    // 右隣のページ取得
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = viewController.view.tag - 1
        
        index += 1
        if index > self.pageInfoList.count - 1 {
            index = 0
        }
        return self.pageInfoList[index].vc
    }
    
    // ページ数
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageInfoList.count
    }
    
    // 遷移アニメーションが完了した時
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            // 前のメニューを非選択状態に
            self.pageInfoList[self.currentPageIndex].menuItemView.didDeselect()
            // インデックス更新
            self.currentPageIndex = self.pageViewController.viewControllers!.last!.view.tag - 1
            // 新しいメニューを選択状態に
            self.pageInfoList[self.currentPageIndex].menuItemView.didSelect()
            // メニューをスクロール
            if self.menuViewMode == .Scroll {
                self.menuScrollView.setContentOffset(CGPoint(x: self.menuScrollOffsetXList[self.currentPageIndex], y: 0), animated: true)
            }
        }
    }
    
    // メニューがタップされた
    func menuDidSelectByTap(index: Int) {
        guard index - 1 != self.currentPageIndex else {
            return
        }
        // 前のメニューを非選択状態に
        self.pageInfoList[self.currentPageIndex].menuItemView.didDeselect()
        // インデックス更新
        let direction: UIPageViewControllerNavigationDirection = index - 1 > self.currentPageIndex ? .forward : .reverse
        self.currentPageIndex = index - 1
        // 画面入れ替え
        self.pageViewController.setViewControllers(
            [self.pageInfoList[self.currentPageIndex].vc],
            direction  : direction,
            animated   : true,
            completion : { (_) in
                self.shouldIgnoreScrollDelegate = false
        })
        // 新しいメニューを選択状態に
        self.pageInfoList[self.currentPageIndex].menuItemView.didSelect()
        // メニューをスクロール
        if self.menuViewMode == .Scroll {
            self.menuScrollView.setContentOffset(CGPoint(x: self.menuScrollOffsetXList[self.currentPageIndex], y: 0), animated: true)
        }
        
        self.shouldIgnoreScrollDelegate = true
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.menuBackgroundView.frame.origin.x = self.pageInfoList[self.currentPageIndex].menuItemView.frame.origin.x
        })
    }
    
    // スクロールデリゲート
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.menuViewMode == .Scroll {
            let movedOffsetX = scrollView.contentOffset.x - self.view.frame.size.width
            var offsetXDiff: CGFloat = 0
            if movedOffsetX < 0 && self.currentPageIndex > 0 {
                offsetXDiff = self.menuScrollOffsetXList[self.currentPageIndex] - self.menuScrollOffsetXList[self.currentPageIndex - 1]
            }
            else if movedOffsetX > 0 && self.currentPageIndex < self.pageInfoList.count - 1 {
                offsetXDiff = self.menuScrollOffsetXList[self.currentPageIndex + 1] - self.menuScrollOffsetXList[self.currentPageIndex]
            }
            if offsetXDiff != 0 {
                self.menuScrollView.contentOffset.x = self.menuScrollOffsetXList[self.currentPageIndex] + movedOffsetX / (self.view.frame.size.width / offsetXDiff)
            }
        }
        else {
            guard !self.shouldIgnoreScrollDelegate else {
                return
            }
            let movedOffsetX = scrollView.contentOffset.x - self.view.frame.size.width
            self.menuBackgroundView.frame.origin.x = self.pageInfoList[self.currentPageIndex].menuItemView.frame.origin.x + movedOffsetX / CGFloat(self.pageInfoList.count)
            if self.menuBackgroundView.frame.origin.x > self.view.frame.size.width - self.menuBackgroundView.frame.width / 2 {
                self.menuBackgroundView.frame.origin.x -= self.view.frame.size.width
            }
            else if self.menuBackgroundView.frame.origin.x < -self.menuBackgroundView.frame.width / 2 {
                self.menuBackgroundView.frame.origin.x += self.view.frame.size.width
            }
        }
    }
}
