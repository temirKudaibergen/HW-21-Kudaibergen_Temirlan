//
//  CustomTableViewCell.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 17.05.2023.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    var card: Card? {
        didSet {
            cardName.text = card?.name
            cardType.text = card?.type
        }
    }
    
    var filteredArray: Card? {
        didSet {
            cardName.text = card?.name
            cardType.text = card?.type
        }
    }
    
//    MARK: UI
    
    private lazy var cardName: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = .black
        return lable
    }()
    
    private lazy var cardType: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = .systemGray
        return lable
    }()
    
//    MARK: Lifecyle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Setup
    
    private func setupHierarchy() {
        contentView.addSubview(cardName)
        contentView.addSubview(cardType)
    }
    
    private func setupLayout() {
        cardName.snp.makeConstraints {
            $0.centerY.equalTo(contentView).offset(5)
            $0.left.equalTo(contentView).offset(20)
        }
        
        cardType.snp.makeConstraints {
            $0.centerY.equalTo(cardName).offset(-5)
            $0.left.equalTo(contentView).offset(20)
        }
    }
    
    //    MARK: Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryView = .none
        self.card = nil
    }
}
