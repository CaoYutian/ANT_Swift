//
//  AppTabBarController.swift
//  ANT_iOS
//
//  Created by 宇玄丶 on 2017/6/2.
//  Copyright © 2017年 qianmo. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController, AppTabBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let home = HomeViewController()
        home.tabBarItem.title = "首页"
        home.tabBarItem.image = UIImage.init(named: "ic_tabbar_home_normal")
        home.tabBarItem.selectedImage = UIImage.init(named: "ic_tabbar_home_selected")?.withRenderingMode(.alwaysOriginal)
        
        let farm = FarmViewController()
        farm.tabBarItem.title = "农田"
        farm.tabBarItem.image = UIImage.init(named: "ic_tabbar_farm_normal")
        farm.tabBarItem.selectedImage = UIImage.init(named: "ic_tabbar_farm_selected")?.withRenderingMode(.alwaysOriginal)
        
        let circle = CircleViewController()
        circle.tabBarItem.title = "圈子"
        circle.tabBarItem.image = UIImage.init(named: "ic_tabbar_circle_normal")
        circle.tabBarItem.selectedImage = UIImage.init(named: "ic_tabbar_circle_selected")?.withRenderingMode(.alwaysOriginal)
        
        let mine = MineViewController()
        mine.tabBarItem.title = "我的"
        mine.tabBarItem.image = UIImage.init(named: "ic_tabbar_mine_normal")
        mine.tabBarItem.selectedImage = UIImage.init(named: "ic_tabbar_mine_selected")?.withRenderingMode(.alwaysOriginal)
        
        //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
        let tabbar = AppTabBar()
        tabbar.myDelegate = self
        //kvc实质是修改了系统的_tabBar
        self.setValue(tabbar, forKeyPath: "tabBar")
        
        self.tabBar.tintColor = UIColor.orange
        self.viewControllers = [home, farm, circle, mine];
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        // 使用枚举遍历,判断选中的tabBarItem等于数组中的第几个
        for (key, value) in (tabBar.items?.enumerated())! {
            if value == item {
                print(key)
                // 将下标传入动画方法
                animationWithIndex(index: key)
            }
        }
    }
    
    func tabBarPlusBtnClick(tabBar: AppTabBar) {
        print("中间按钮")
    }
    
    func animationWithIndex(index: NSInteger) {
        var tabbarbuttonArray:[Any] = [Any]()
        for tabBarButton in self.tabBar.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabbarbuttonArray.append(tabBarButton)
            }
        }
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        pulse.duration = 0.2
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = NSNumber.init(value: 0.7)
        pulse.toValue = NSNumber.init(value: 1.0)
        (tabbarbuttonArray[index] as AnyObject).layer.add(pulse, forKey: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
