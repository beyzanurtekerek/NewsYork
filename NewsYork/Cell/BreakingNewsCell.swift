//
//  BreakingNewsCell.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 28.02.2025.
//

import UIKit
import SDWebImage

class BreakingNewsCell: UICollectionViewCell {
    
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill // fit kullanma gelmiyor

        publishedDateLabel.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        publishedDateLabel.layer.cornerRadius = 5
        publishedDateLabel.layer.masksToBounds = true
        
        titleLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.lineBreakMode = .byTruncatingTail
    }

    func configure(with article: NewsArticle) {
        titleLabel.text = article.title
        descriptionLabel.text = article.abstract
        publishedDateLabel.text = formatDate(article.publishedDate)
        
        if let imageUrl = article.imageUrl, !imageUrl.isEmpty {
            loadImage(from: imageUrl)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }
        
        print("loading image from URL: \(urlString)")
        
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: { image, error, cacheType, url in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                self.imageView.image = UIImage(named: "placeholder")
            } else {
                print("image loaded succesfully from: \(url?.absoluteString ?? "Unknow URL")")
            }
        })
    }
    
    func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            return outputFormatter.string(from: date)
        }
        return dateString
    }
}
