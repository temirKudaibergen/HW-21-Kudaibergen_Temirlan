//
//  MainView.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 15.05.2023.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func selectedCell(selectedSetting: Card)
}

final class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    private var cards = [Card]()
    private var filteredArray = [Card]()
    
//    MARK: UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(ViewController.self,
                           forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the name of the card"
        textField.textColor = .black
        textField.textAlignment = .left
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var serachButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .gray
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self,
                         action: #selector(serchCard),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(serachButton)
        stack.spacing = 10
        return stack
    }()
    
//    MARK: Initial
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupViews()
        setupLayout()
    }
    
//    MARK: Setup
    
    private func setupViews() {
        addSubview(tableView)
        addSubview(stack)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(-5)
            $0.right.equalToSuperview().offset(5)
            $0.height.equalTo(170)
        }
    }
    
    //    MARK: Actions

    @objc
    private func serchCard() {
        filteredArray.removeAll()
        
        if textField.hasText {
            for card in cards {
                if card.name == textField.text {
                    filteredArray.append(card)
                    tableView.reloadData()
                }
            }
        } else {
            tableView.reloadData()
        }
    }
}


//    MARK: Extension

extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredArray.isEmpty {
            return cards.count
        } else {
            return filteredArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filteredArray.isEmpty {
            let info = cards[indexPath.row]
            let cell = UITableViewCell(style: .subtitle,
                                       reuseIdentifier: "Subtitle2")
            cell.textLabel?.text = info.name
            cell.detailTextLabel?.text = info.type
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            let info = filteredArray[indexPath.row]
            let cell = UITableViewCell(style: .subtitle,
                                       reuseIdentifier: "Subtitle2")
            cell.textLabel?.text = info.name
            cell.detailTextLabel?.text = info.type
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        viewController.card = cards[indexPath.row]
    }
}
