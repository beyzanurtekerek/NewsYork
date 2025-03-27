//
//  DetailVC.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 25.03.2025.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController {
    
    var article: NewsArticle?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        guard let article = article else { return }
        
        titleLabel.text = article.title
        
        byLineLabel.text = article.byline.isEmpty ? "Unknown Author" : article.byline
        
        contentLabel.text = article.abstract
        
        if let imageUrlString = article.imageUrl, let url = URL(string: imageUrlString) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        
        // Save butonunun varsayılan durumu (detaylı kaydetme yapısı daha sonra eklenecek)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        let bookmarkImage = UIImage(systemName: "bookmark", withConfiguration: config)
        saveButton.setImage(bookmarkImage, for: .normal)
    }
    
    @IBAction func readMoreButtonClicked(_ sender: Any) {
        guard let article = article, let url = URL(string: article.url) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func savedButtonClicked(_ sender: Any) {
        // kaydetme islemi yapılacak burda
    }
    
}
