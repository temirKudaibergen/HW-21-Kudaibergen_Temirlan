//
//  MainView.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 15.05.2023.
//

import UIKit
import SnapKit
import Alamofire

protocol MainViewDelegate: AnyObject {
    func selectedCell(selectedSetting: Card?)
}

final class MainView: UIView {
    
    //    MARK: Properties
    
    weak var viewController: ViewController?
    weak var delegate: MainViewDelegate?
    private var cards = [Card?]()
    private var filteredArray = [Card]()
    
    //    MARK: UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the name of the card"
        textField.textColor = .black
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var serachButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .lightGray
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self,
                         action: #selector(serchCard),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .lightGray
        indicator.startAnimating()
        return indicator
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(serachButton)
        stack.spacing = 7
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
        fetchCard()
    }
    
    //    MARK: Setup
    
    private func setupViews() {
        addSubview(tableView)
        addSubview(stack)
        addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(110)
            $0.left.right.equalToSuperview().inset(10)
            $0.height.equalTo(35)
            $0.width.equalTo(350)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(stack.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    //    MARK: Actions
    
    @objc
    private func serchCard() {
        filteredArray.removeAll()
        if textField.hasText {
            for card in filteredArray {
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

extension MainView: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredArray.isEmpty {
            return filteredArray.count
        } else {
            return cards.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !filteredArray.isEmpty {
            let info = filteredArray[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                     for: indexPath) as? CustomTableViewCell
            var content = cell?.defaultContentConfiguration()
            content?.text = info.name
            content?.secondaryText = info.type
            cell?.contentConfiguration = content
            return cell ?? UITableViewCell()
        } else {
            let info = cards[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                     for: indexPath) as? CustomTableViewCell
            var content = cell?.defaultContentConfiguration()
            content?.text = info?.name
            content?.secondaryText = info?.type
            cell?.contentConfiguration = content
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedSetting = cards[indexPath.row] {
            delegate?.selectedCell(selectedSetting: selectedSetting)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            filteredText(text + string)
        }
        return true
    }
    
    func filteredText(_ query: String) {
        filteredArray.removeAll()
        for card in cards {
            guard let card = card else { return }
            if ((card.name.starts(with: query.lowercased()))) {
                filteredArray.append(card)
            }
            tableView.reloadData()
        }
    }
}

extension MainView {
    func fetchCard() {
        if filteredArray.isEmpty {
            let request = AF.request("https://api.magicthegathering.io/v1/cards")
            request.responseDecodable(of: Cards.self) { [self] (data) in
                guard let cardData = data.value else {
                    viewController?.alert(title: "Error", message: "Data loading error")
                    return
                }
                let cards = cardData.cards
                self.cards = cards
                tableView.reloadData()
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        } else {
            let request = AF.request("https://api.magicthegathering.io/v1/cards")
            request.responseDecodable(of: Cards.self) { [self] (data) in
                guard let cardData = data.value else {
                    viewController?.alert(title: "Error", message: "Data loading error")
                    return
                }
                let cards = cardData.cards
                self.filteredArray = cards
                tableView.reloadData()
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
}
