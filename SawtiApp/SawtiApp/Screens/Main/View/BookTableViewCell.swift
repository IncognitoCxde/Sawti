//
//  BookTableViewCell.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 01/11/24.
//

import UIKit
import SnapKit

class BookTableViewCell: UITableViewCell {
    
    private let bookImageView = UIImageView()
    private let nameLabel = UILabel()
    private let authorLabel = UILabel()
    private let ratingLabel = UILabel()
    private let bookmarkButton = UIButton(type: .system)
    private let cellBackground = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        cellBackground.backgroundColor = UIColor(named: "Light Green")
        cellBackground.layer.cornerRadius = 12
        cellBackground.layer.borderWidth = 1
        cellBackground.layer.borderColor = UIColor(named: "Gray")?.cgColor
        cellBackground.clipsToBounds = true
        contentView.addSubview(cellBackground)
        
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.clipsToBounds = true
        bookImageView.layer.cornerRadius = 6
        cellBackground.addSubview(bookImageView)
        
        nameLabel.font = UIFont(name: "Inter24pt-ExtraBold", size: 14)
        nameLabel.textColor = UIColor(named: "Dark")
        cellBackground.addSubview(nameLabel)
        
        authorLabel.font = UIFont(name: "Inter-Regular", size: 13)
        authorLabel.textColor = .systemGray
        cellBackground.addSubview(authorLabel)
        
        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        cellBackground.addSubview(ratingLabel)
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.tintColor = .gray
        cellBackground.addSubview(bookmarkButton)
        
        cellBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        bookImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(8)
            make.width.equalTo(70)
            make.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(bookImageView.snp.right).offset(15)
            make.right.equalTo(bookmarkButton.snp.left).offset(-8)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(15)
            make.left.equalTo(bookImageView.snp.right).offset(15)
            make.right.equalTo(bookmarkButton.snp.left).offset(10)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(4)
            make.left.equalTo(bookImageView.snp.right).offset(15)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(15)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }
    
    func configure(with book: Book) {
        bookImageView.image = UIImage(named: book.imageName)
        nameLabel.text = book.name
        authorLabel.text = book.author
        ratingLabel.text = String(repeating: "★", count: Int(book.rating)) + String(repeating: "☆", count: 5 - Int(book.rating))
        
        let bookmarkImageName = book.isBookmarked ? "bookmark.fill" : "bookmark"
        bookmarkButton.setImage(UIImage(systemName: bookmarkImageName), for: .normal)
    }
}
