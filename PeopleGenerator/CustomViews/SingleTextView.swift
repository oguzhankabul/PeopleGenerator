//
//  NoOneHereView.swift
//  PeopleGenerator
//
//  Created by Oğuzhan Kabul on 14.06.2023.
//

import UIKit

final class SingleTextView: BaseView {
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(tagLabel)
        setupLayout()
    }
    
    override func setupLayout() {
        super.setupLayout()
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: topAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func set(_ viewModel: SingleTextViewModel) {
        tagLabel.text = viewModel.tagText
    }
}
