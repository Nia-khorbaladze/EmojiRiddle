//
//  CategoryTableViewCell.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    static let identifier = "CategoryTableViewCell"
    
    // MARK: - UI Elements
    private lazy var categoryContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 21
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "FFDAF9")
        
        return view
    }()
    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "100735")
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "100735")
        
        return view
    }()
    
    // MARK: - Setup
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        categoryContainerView.addSubview(categoryTitle)
        contentView.addSubview(categoryContainerView)
        contentView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            categoryTitle.centerXAnchor.constraint(equalTo: categoryContainerView.centerXAnchor),
            categoryTitle.centerYAnchor.constraint(equalTo: categoryContainerView.centerYAnchor),
            categoryContainerView.heightAnchor.constraint(equalToConstant: 50),
            categoryContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 56),
            separator.topAnchor.constraint(equalTo: categoryContainerView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    // MARK: - Internal functions
    
    func configureCell(text: String) {
        categoryTitle.text = text
    }
}
