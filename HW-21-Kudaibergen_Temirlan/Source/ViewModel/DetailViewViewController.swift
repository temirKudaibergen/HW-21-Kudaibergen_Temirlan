//
//  DetailViewViewController.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 16.05.2023.
//

import UIKit

final class DetailViewViewController: UIViewController {
    
    //    MARK: Properties
    
    var card: Card?
    
    private var onboardingView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }
    
    private func configureView() {
        guard let setting = card else { return }
        onboardingView?.fillSettings(model: setting)
        guard let picture = card?.imageUrl else { return }
        onboardingView?.makeRequestUrl(urlRequest: picture)
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


