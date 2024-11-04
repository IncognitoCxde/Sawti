//
//  CategoryCell.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 28/10/24.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter18pt-Bold", size: 13)
        label.textColor = UIColor(named: "Dark")
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.backgroundColor = UIColor(named: "UI Green")
        contentView.layer.cornerRadius = 18
        contentView.layer.masksToBounds = true
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        label.text = text
    }
}
