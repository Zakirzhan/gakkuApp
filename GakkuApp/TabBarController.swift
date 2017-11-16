//
//  TabBarController.swift
//  GakkuApp
//
//  Created by macbook on 02.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Sugar

struct MainTabBarItem {
    var id: Int
    var icon: UIImage?
    var controller: UIViewController
}

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarItems = [
            MainTabBarItem(id: 1, icon: Constant.Icon.homeIcon, controller: NewsViewController()),
            MainTabBarItem(id: 2, icon: Constant.Icon.chartIcon, controller: ChartsViewController()),
            MainTabBarItem(id: 3, icon: Constant.Icon.radyoIcon, controller: RadioViewController()),
            MainTabBarItem(id: 4, icon: Constant.Icon.channelIcon, controller: CategoriesViewController()),
            MainTabBarItem(id: 5, icon: Constant.Icon.aboutIcon, controller: AboutViewController())
        ]
        
        viewControllers = tabBarItems.flatMap {
            UINavigationController(rootViewController: $0.controller).then {
                $0.navigationBar.tintColor = .white
                $0.navigationBar.barStyle = .black
                $0.navigationBar.barTintColor = Constant.Colors.bgColorDark
            }
        }
        
        for (index, item) in tabBarItems.enumerated() {
            setUpTabBarItem(tabBar.items![index],
                            image: item.icon,
                            selectedImage: item.icon)
        }
        tabBar.isTranslucent = false  // прозрачность = фалс
        tabBar.tintColor = Constant.Colors.dark
        tabBar.unselectedItemTintColor = Constant.Colors.dark
        tabBar.barTintColor =  Constant.Colors.bgColorDark
    }
    
    fileprivate func setUpTabBarItem(_ tabBarItem: UITabBarItem?,
                                     image: UIImage?,
                                     selectedImage: UIImage?) {
        tabBarItem?.image = image?.imageWithColor(tintColor: .gray).withRenderingMode(.alwaysOriginal)
        tabBarItem?.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        tabBarItem?.selectedImage = selectedImage?.imageWithColor(tintColor: .white).withRenderingMode(.alwaysOriginal)
    }
}

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
