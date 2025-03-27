//
//  HomeVC.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 22.02.2025.
//

import UIKit

class HomeVC: UIViewController, UIScrollViewDelegate {
    
    private let baseVC = BaseVC()
    private let viewModel = HomeVM()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(baseVC)
        view.addSubview(baseVC.view)
        baseVC.didMove(toParent: self)

        setupCollectionView()
        setupTableView()
        setupBindings()
        
        showLoadingIndicator()
        
        viewModel.fetchBreakingNews()
        
        pageControl.numberOfPages = viewModel.breakingNewsArticles.count
        pageControl.currentPage = 0
 
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
            guard let self = self else { return }
            
            self.hideLoadingIndicator()
            
            self.collectionView.reloadData()
            self.tableView.reloadData()
            
            self.pageControl.numberOfPages = self.viewModel.breakingNewsArticles.count
            self.pageControl.currentPage = 0
        }
        
        viewModel.onDataError = { [weak self] error in
            guard let self = self else { return }
            
            self.hideLoadingIndicator()
            self.showErrorAlert(message: error.localizedDescription)
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }
    }
    
    func navigateToDetailVC(with article: NewsArticle) {
        performSegue(withIdentifier: "toDetailVC", sender: article)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC",
           let detailVC = segue.destination as? DetailVC,
           let article = sender as? NewsArticle {
            detailVC.article = article
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
        let width = collectionView.frame.width - 15
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArticle = viewModel.breakingNewsArticles[indexPath.item]
        navigateToDetailVC(with: selectedArticle)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = viewModel.recommendedArticles[indexPath.row]
        navigateToDetailVC(with: selectedArticle)
    }
    
}
