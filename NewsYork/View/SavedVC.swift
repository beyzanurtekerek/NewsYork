//
//  SavedVC.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 25.02.2025.
//

import UIKit

class SavedVC: UIViewController {

    private let baseVC = BaseVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(baseVC)
        view.addSubview(baseVC.view)
        baseVC.didMove(toParent: self)

    }

}
