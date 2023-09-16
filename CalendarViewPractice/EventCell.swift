//
//  EventCell.swift
//  CalendarViewPractice
//
//  Created by YUJIN KWON on 2023/09/16.
//

import UIKit
import SnapKit

final class EventCell: UITableViewCell {
    static let identifier = "EventCell"
    
    lazy var profileIconView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .tertiaryLabel
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setUp() {
        [profileIconView, titleLabel].forEach { addSubview($0) }
        
        profileIconView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileIconView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(15)
        }
    }
}
