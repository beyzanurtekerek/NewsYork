//
//  BaseVC.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 26.02.2025.
//

import UIKit
import FirebaseAuth

class BaseVC: UIViewController {
    
    private let headerView = UIView()
    private let appNameLabel = UILabel()
    private let menuButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
    }

    private func setupHeader() {
        headerView.backgroundColor = .white
        view.addSubview(headerView)
        
        appNameLabel.text = "News York"
        appNameLabel.textColor = .black
        appNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        headerView.addSubview(appNameLabel)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
        let menuIcon = UIImage(systemName: "line.horizontal.3", withConfiguration: largeConfig)
        menuButton.setImage(menuIcon, for: .normal)
        menuButton.tintColor = .black
        menuButton.addTarget(self, action: #selector(menuButtonClicked), for: .touchUpInside)
        headerView.addSubview(menuButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            appNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            appNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            menuButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            menuButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
       ])
    }
    
    @objc private func menuButtonClicked() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let signoutButton = UIAlertAction(title: "Sign out", style: .default, handler: { _ in
            self.logout()
        })
        alert.addAction(signoutButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            navigateToLoginScreen()
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    private func navigateToLoginScreen() {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        }
    }
    
}
