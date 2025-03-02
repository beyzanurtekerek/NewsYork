//
//  HomeVC.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 22.02.2025.
//

import UIKit

class HomeVC: UIViewController {
    
    private let baseVC = BaseVC()
    private let viewModel = HomeVM()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(baseVC)
        view.addSubview(baseVC.view)
        baseVC.didMove(toParent: self)

        setupCollectionView()
        setupTableView()
        setupBindings()
        viewModel.fetchBreakingNews()
 
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
    }
    
    func setupBindings() {
        viewModel.onDataFetched = { [weak self] in
            self?.collectionView.reloadData()
            self?.tableView.reloadData()
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.breakingNewsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreakingNewsCell", for: indexPath) as! BreakingNewsCell
        
        let article = viewModel.breakingNewsArticles[indexPath.item]
        cell.configure(with: article)
        cell.imageView.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20
        let height = collectionView.frame.height - 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recommendedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
        
        let article = viewModel.recommendedArticles[indexPath.row]
        cell.configure(with: article)
        
        cell.recommendationImageView.layer.cornerRadius = 10
        cell.recommendationImageView.layer.masksToBounds = true
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
}
