//
//  ViewController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 25/10/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    
    let exploreTitle = UILabel()
    let searchBar = ATCTextField()
    let searchLogo = UIImageView()
    let topicsTitle = UILabel()
    var collectionView: UICollectionView!
    let recentTitle = UILabel()
    
    private let tableView = UITableView()
    private var books: [Book] = [
        Book(name: "Sahih Al-Bukhari", author: "Imam Al Bukhari", imageName: "Sahih", isBookmarked: false, rating: 5.0),
        Book(name: "1984", author: "George Orwell", imageName: "1984", isBookmarked: false, rating: 4.7),
        Book(name: "A History Of Tajiks", author: "Richard Foltz", imageName: "Tajiks", isBookmarked: true, rating: 4.9)
    ]
    
    let categories = ["Self-Enlightment", "Culture & Society", "Fiction", "Mind & Philosophy", "Tajik-Persian Poetry", "Tajik History", "Education", "World History", "Islamic", "Technology"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = CGSize(width: categories.count, height: categories.count + 30)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topicsTitle.snp.top).inset(35)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(390)
        }
    }
    
    // MARK: - UI
    
    func setUpUI() {
        view.backgroundColor = UIColor(named: "Milk")
        configureNavTitle()
        configureLabels()
        configureSearchBar()
        setupTableView()
        makeConstraints()
    }
    
    // MARK: - Navigation
    
    func configureNavTitle() {
        navigationItem.title = "صوتي"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "Brown"),
                              NSAttributedString.Key.font: UIFont(name: "Inter24pt-ExtraBold", size: 24)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
    
    // MARK: - TableView
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentTitle.snp.top).inset(30)
            make.right.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "BookTableViewCell")
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Configuration
    
    func configureLabels() {
        exploreTitle.text = "Explore"
        exploreTitle.textColor = UIColor(named: "Dark")
        exploreTitle.font = UIFont(name: "Inter24pt-Bold", size: 18)
        view.addSubview(exploreTitle)
        
        topicsTitle.text = "Topics"
        topicsTitle.textColor = UIColor(named: "Dark")
        topicsTitle.font = UIFont(name: "Inter24pt-Bold", size: 18)
        view.addSubview(topicsTitle)
        
        recentTitle.text = "Recently Viewed"
        recentTitle.textColor = UIColor(named: "Dark")
        recentTitle.font = UIFont(name: "Inter24pt-Bold", size: 18)
        view.addSubview(recentTitle)
    }
    
    func configureSearchBar() {
        searchBar.placeholder = "Title, author or keyword"
        searchBar.backgroundColor = UIColor(named: "Light Green")
        searchBar.keyboardType = .default
        searchBar.borderStyle = .none
        searchBar.layer.cornerRadius = 15
        view.addSubview(searchBar)
        
        searchLogo.image = UIImage(systemName: "magnifyingglass")
        searchLogo.tintColor = UIColor(named: "Brown")
        view.addSubview(searchLogo)
    }
    
    // MARK: - Constraints
    
    func makeConstraints() {
        exploreTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.left.equalToSuperview().inset(25)
        }
        
        searchBar.snp.makeConstraints{ make in
            make.top.equalTo(exploreTitle.snp.bottom).offset(15)
            make.right.equalTo(exploreTitle.snp.right).offset(285)
            make.width.equalTo(355)
            make.height.equalTo(55)
        }
        
        searchLogo.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.top).inset(20)
            make.left.equalTo(searchBar.snp.left).inset(15)
        }
        
        topicsTitle.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.left.equalTo(exploreTitle.snp.left)
        }
        recentTitle.snp.makeConstraints { make in
            make.top.equalTo(exploreTitle.snp.bottom).offset(340)
            make.left.equalTo(exploreTitle.snp.left)
        }
    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: categories[indexPath.item])
        return cell
    }
    
    // MARK: - Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.item]
        let font = UIFont(name: "Inter18pt-Bold", size: 12)
        let textWidth = text.size(withAttributes: [.font: font!]).width + 20
        return CGSize(width: textWidth, height: 20)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        
        let book = books[indexPath.row]
        cell.configure(with: book)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
