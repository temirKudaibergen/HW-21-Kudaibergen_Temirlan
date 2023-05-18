//
//  DetailView.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 17.05.2023.
//

import UIKit
import SnapKit
import Alamofire

final class DetailView: UIView {
    
    //    MARK: Properties
    
    weak var viewController: ViewController?
    private var cards = [Card?]()
    private var filteredArray = [Card]()
    
    //    MARK: UI
    
    private lazy var cardName: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 35)
        lable.textColor = .black
        lable.numberOfLines = 0
        return lable
    }()
    
    private lazy var cardType: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = .black
        return lable
    }()
    
    private lazy var setName: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = .black
        return lable
    }()
    
    private lazy var manaCost: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = .black
        return lable
    }()
    
    private lazy var cmc: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = .black
        return lable
    }()
    
    private lazy var rarity: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = .black
        return lable
    }()
    
    private lazy var artist: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = .black
        return lable
    }()
    
    private lazy var textInCard: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.numberOfLines = 0
        lable.textColor = .black
        return lable
    }()
    
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .lightGray
        indicator.startAnimating()
        return indicator
    }()
    
    //    MARK: Init
    
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
        backgroundColor = .white
        addSubview(cardName)
        addSubview(cardType)
        addSubview(setName)
        addSubview(manaCost)
        addSubview(cmc)
        addSubview(rarity)
        addSubview(artist)
        addSubview(textInCard)
        addSubview(cardImageView)
        addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        cardName.snp.makeConstraints {
            $0.top.equalToSuperview().offset(90)
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().inset(10)
        }
        cardType.snp.makeConstraints {
            $0.top.equalTo(cardName.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(25)
        }
        setName.snp.makeConstraints {
            $0.top.equalTo(cardType).offset(30)
            $0.left.equalToSuperview().offset(25)
        }
        manaCost.snp.makeConstraints {
            $0.top.equalTo(setName).offset(30)
            $0.left.equalToSuperview().offset(25)
        }
        cmc.snp.makeConstraints {
            $0.top.equalTo(manaCost).offset(30)
            $0.left.equalToSuperview().offset(25)
        }
        rarity.snp.makeConstraints {
            $0.top.equalTo(cmc).offset(30)
            $0.left.equalToSuperview().offset(25)
        }
        artist.snp.makeConstraints {
            $0.top.equalTo(rarity).offset(30)
            $0.left.equalToSuperview().offset(25)
        }
        textInCard.snp.makeConstraints {
            $0.top.equalTo(artist).offset(30)
            $0.left.right.equalToSuperview().inset(25)
        }
        cardImageView.snp.makeConstraints {
            $0.top.equalTo(textInCard.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(300)
        }
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(cardImageView)
        }
    }
    
    func fillSettings(model: Card) {
        cardName.text = model.name
        cardType.text = "Card type: \(String(describing: model.type ?? "No data"))"
        setName.text = "Set name: \(String(describing: model.setName ?? "No data"))"
        manaCost.text = "Mana cost: \(String(describing: model.manaCost ?? "No data"))"
        cmc.text = "CMC: \(String(describing: model.cmc ?? 0))"
        rarity.text = "Rarity: \(String(describing: model.rarity ?? "No data"))"
        artist.text = "Artist: \(String(describing: model.artist ?? "No data"))"
        textInCard.text = "Text: \(String(describing: model.text ?? "No data"))"
    }
    
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
            }
        }
    }
}

extension DetailView {
    public func makeRequestUrl(urlRequest: String) {
        let urlRequest = URL(string: urlRequest)
        guard let url = urlRequest else  {
            viewController?.alert(title: "Error", message: "Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                if (error as! URLError).code == URLError.notConnectedToInternet {
                    switch (error as! URLError).code {
                    case URLError.resourceUnavailable:
                        self.viewController?.alert(title: "Error", message: "The resource is unavailable")
                    case URLError.badServerResponse:
                        self.viewController?.alert(title: "Error", message: "No response from the server")
                    case URLError.networkConnectionLost:
                        self.viewController?.alert(title: "Error", message: "Internet connection is not stable")
                    default:
                        self.viewController?.alert(title: "Error", message: "Unknown error")
                    }
                }
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    self.viewController?.alert(title: "Error", message: "Response status is \(response.statusCode)")
                }
                guard let data = data else {
                    self.viewController?.alert(title: "Error", message: "No data")
                    return
                }
                DispatchQueue.main.async() { [weak self] in
                    self?.cardImageView.image = UIImage(data: data)
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }.resume()
    }
}

