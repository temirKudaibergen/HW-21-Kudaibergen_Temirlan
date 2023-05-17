//
//  DetailViewViewController.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 16.05.2023.
//

import UIKit

class DetailViewViewController: UIViewController {
    
    var card: Card?
    
    private var onboardingView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }
    
    func configureView() {
        guard let setting = card else { return }
        onboardingView?.fillSettings(model: setting)
    }

    //    MARK: Lifecyle
    
    override func loadView() {
        super.loadView()
        view = DetailView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView() 
        configureView()
    }
}


