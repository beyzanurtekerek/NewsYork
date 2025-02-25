//
//  HomeVC.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 22.02.2025.
//

import UIKit

class HomeVC: UIViewController {

    private let baseVC = BaseVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(baseVC)
        view.addSubview(baseVC.view)
        baseVC.didMove(toParent: self)

    }

}
