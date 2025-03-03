//
//  RecommendationCellTableViewCell.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 2.03.2025.
//

import UIKit
import SDWebImage

class RecommendationCell: UITableViewCell {

    @IBOutlet weak var recommendationImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        recommendationImageView.contentMode = .scaleAspectFill
    }
    
    func configure(with article: NewsArticle) {
        titleLabel.text = article.title
        bylineLabel.text = "• \(article.byline)"
        publishedDateLabel.text = formatDate(article.publishedDate)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowRadius = 5
        
        if let imageUrl = article.imageUrl, !imageUrl.isEmpty {
            loadImage(from: imageUrl)
        } else {
            recommendationImageView.image = UIImage(named: "placeholder")
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }
        
        print("loading image from URL: \(urlString)")
        
        recommendationImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: { image, error, cacheType, url in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                self.recommendationImageView.image = UIImage(named: "placeholder")
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
