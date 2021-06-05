//
//  RMSessionDetailLargeStackView.swift
//  RunRunRun
//
//  Created by Mohammed Ahmad on 9/9/20.
//  Copyright © 2020 Mohammed Ahmad. All rights reserved.
// 

import UIKit

final class RMSessionDetailLargeStackView: UIStackView {
    
    let valueLabel = RMTitleLabel(textAlignment: .center,
                                  fontSize: 90,
                                  color: .black)
    let descriptionLabel = RMSecondaryTitleLabel(fontSize: 17,
                                                 fontWeight: .semibold,
                                                 color: .darkGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(value: String, subtitle: String) {
        self.init(frame: .zero)
        valueLabel.text = value
        descriptionLabel.text = subtitle
    }
}

extension RMSessionDetailLargeStackView {
    
    private func configure() {
        axis = .vertical
        distribution = .fill
        alignment = .center
        spacing = -8
        
        addArrangedSubview(valueLabel)
        addArrangedSubview(descriptionLabel)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
