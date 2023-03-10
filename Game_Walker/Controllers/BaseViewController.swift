//
//  BaseViewController.swift
//  Game_Walker
//
//  Created by Noah Kim on 7/11/22.
//

import UIKit

class BaseViewController: UIViewController {
    //let userData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
    }
    
    func configureNavBar() {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        backButton.setImage(UIImage(named: "back button 1"), for: .normal)
        backButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        let barBackButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barBackButton
    }
    
    @objc func onBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
