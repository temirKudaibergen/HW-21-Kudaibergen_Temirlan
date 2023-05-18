//
//  CustomTableViewCell.swift
//  HW-21-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 17.05.2023.
//

import UIKit
import SnapKit

final class CustomTableViewCell: UITableViewCell {
    
    //    MARK: Properties
    
    var card: Card? {
        didSet {
            cardName.text = card?.name
        }
    }
    
    var filteredArray: Card? {
        didSet {
            cardName.text = card?.name
        }
    }
    
    //    MARK: UI
    
    private lazy var cardName: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = .black
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
    }
    
    private func setupLayout() {
        cardName.snp.makeConstraints {
            $0.centerY.equalTo(contentView).offset(5)
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
