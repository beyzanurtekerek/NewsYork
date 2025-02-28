//
//  Spinner.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 27.02.2025.
//

import UIKit

extension UIViewController {
    
    func showLoadingIndicator() {
        if self.view.viewWithTag(999) != nil { return }
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tag = 999
        spinner.center = self.view.center
        spinner.startAnimating()
        self.view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    func hideLoadingIndicator() {
        if let spinner = self.view.viewWithTag(999) as? UIActivityIndicatorView {
            spinner.stopAnimating()
            spinner.removeFromSuperview()
        }
    }
    
}
