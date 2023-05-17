//
//  ViewController.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 15.05.2023.
//

import UIKit


final class ViewController: UIViewController {
    
    private var cards = [Card]()
    private var filteredArray = [Card]()
    private var onboardingView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
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
        title = "Home Work 21"
        navigationController?.navigationBar.prefersLargeTitles = true
        let viewController = MainView()
        viewController.delegate = self
        view = viewController
    }
}

extension ViewController: MainViewDelegate {
    func selectedCell(selectedSetting: Card) {
        let viewController = DetailViewViewController()
        viewController.card = selectedSetting
        navigationController?.pushViewController(viewController, animated: true)
    }
}
