//
//  ViewController.swift
//  Presentation App
//
//  Created by MacBook on 07.08.2023.
//

import UIKit
import SnapKit

final class PresentationViewController: UIViewController {
    // MARK: - UI
    private lazy var slideView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "globe")
        return imageView
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    

    // MARK: - Setup Views
    private func setupViews() {
        [slideView,
         backButton,
         nextButton].forEach {view.addSubview($0)}
        view.backgroundColor = .white
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
        slideView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(self.view.bounds.width / 6.0)
            make.bottom.equalToSuperview().offset(-self.view.bounds.height / 6.0)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-self.view.bounds.width / 6.0)
            make.bottom.equalToSuperview().offset(-self.view.bounds.height / 6.0)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
    }
}

