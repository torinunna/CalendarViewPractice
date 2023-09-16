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
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiaryLabel
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setUp() {
        [profileImageView, titleLabel].forEach { addSubview($0) }
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(15)
            $0.centerY.equalToSuperview()
        }
    }
}
