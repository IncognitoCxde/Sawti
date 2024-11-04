//
//  CustomTabBar.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 01/11/24.
//

import UIKit
import SnapKit

class CustomTabBarView: UIView {
    
    var tabButtons: [UIButton] = []
    private let selectedItemBackground = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor(named: "Cream")
        
        selectedItemBackground.backgroundColor = UIColor(named: "UI Green")
        selectedItemBackground.layer.cornerRadius = 10
        addSubview(selectedItemBackground)
        
        let icons = ["house", "book", "magnifyingglass", "person.circle"]
        for (index, iconName) in icons.enumerated() {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: iconName), for: .normal)
            button.tintColor = UIColor(named: "Brown")
            button.tag = index
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            addSubview(button)
            tabButtons.append(button)
        }
        
        selectedItemBackground.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.centerX.equalTo(tabButtons[0].snp.centerX)
        }
        
        for (index, button) in tabButtons.enumerated() {
            button.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.height.equalTo(60)
                
                if index == 0 {
                    make.left.equalToSuperview().offset(30)
                } else {
                    make.left.equalTo(tabButtons[index - 1].snp.right).offset(30)
                }
                
                if index == icons.count - 1 {
                    make.right.equalToSuperview().offset(-30)
                }
            }
        }
    }
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let button = tabButtons[index]
        
        selectedItemBackground.snp.remakeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.centerX.equalTo(button.snp.centerX)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
