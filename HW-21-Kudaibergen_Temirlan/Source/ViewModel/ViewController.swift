//
//  ViewController.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 15.05.2023.
//

import UIKit
import Alamofire


final class ViewController: UIViewController {
    
    //    MARK: Properties
    
    private var cards = [Card]()
    private var filteredArray = [Card]()
    
    //    MARK: Function
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertButton)
        present(alert, animated: true, completion: nil)
    }
    
    //    MARK: Lifecyle
    
    override func loadView() {
        super.loadView()
        let mainView = MainView()
        mainView.delegate = self
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //    MARK: Setup
    
    private func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let viewController = MainView()
        viewController.delegate = self
        view = viewController
        view.backgroundColor = .white
    }
}

extension ViewController: MainViewDelegate {
    func selectedCell(selectedSetting: Card?) {
        let viewController = DetailViewViewController()
        viewController.card = selectedSetting
        navigationController?.pushViewController(viewController, animated: true)
    }
}
