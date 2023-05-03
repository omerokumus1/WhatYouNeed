//
//  TabBarController.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 3.05.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initTabBar()
        initTabBarItems()
    }
    
    private func initTabBarItems() {
        initTabBarMapItem()
        initTabBarInfoItem()
    }
    private func initTabBarMapItem() {
        let mapItem = tabBar.items!.first!
        let config = UIImage.SymbolConfiguration(scale: .medium)
        mapItem.image = UIImage.init(systemName: "map")!
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            .withConfiguration(config)
        mapItem.selectedImage = UIImage.init(systemName: "map.fill")!
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            .withConfiguration(config)
    }
    
    private func initTabBarInfoItem() {
        let infoItem = tabBar.items!.last!
        let config = UIImage.SymbolConfiguration(scale: .medium)
        infoItem.image = UIImage.init(systemName: "person")!
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            .withConfiguration(config)
        infoItem.selectedImage = UIImage.init(systemName: "person.fill")!
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            .withConfiguration(config)
    }
    
    private func initTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .red
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        setTabBarItemColors(appearance.inlineLayoutAppearance)
        setTabBarItemColors(appearance.compactInlineLayoutAppearance)
        tabBar.standardAppearance = appearance
    }
    
    @available(iOS 13.0, *)
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        let normalColor = UIColor.darkGray
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: normalColor,
                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(13.0))]
        
        let selectedColor = UIColor(red: 76, green: 8, blue: 39, alpha: 1)
        itemAppearance.selected.iconColor = selectedColor
        itemAppearance.selected.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: selectedColor,
                                                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(14.0)) ]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
