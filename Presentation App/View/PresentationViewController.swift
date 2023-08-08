//
//  ViewController.swift
//  Presentation App
//
//  Created by MacBook on 07.08.2023.
//

import UIKit
import SnapKit

final class PresentationViewController: UIViewController, MediaView {
    
    // MARK: - Properties
    var presenter: SlidePresenter?
    // MARK: - UI
    private lazy var slideView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrowshape.left.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 140,
                                                                           weight: .bold,
                                                                           scale: .large))?
            .withTintColor(UIColor(named: "ButtonColor") ?? .red, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrowshape.right.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 140,
                                                                           weight: .bold,
                                                                           scale: .large))?
            .withTintColor(UIColor(named: "ButtonColor") ?? .red, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = UIColor(named: "PrimaryColor")
        presenter = SlidePresenter(view: self, slideService: SlideService())
    }
    

    // MARK: - Setup Views
    private func setupViews() {
        [slideView,
         backButton,
         nextButton].forEach {view.addSubview($0)}
        view.backgroundColor = .white
    }
    
    func showMedia(_ mediaItem: Slide) {

        slideView.image = UIImage(named: mediaItem.content)

    }
    
    @objc func prevButtonTapped() {
        if let presenter = presenter {
            presenter.loadPreviousMedia()
        }
    }

    @objc func nextButtonTapped() {
        if let presenter = presenter {
            presenter.loadNextMedia()
        }
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
        }
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-self.view.bounds.width / 6.0)
            make.bottom.equalToSuperview().offset(-self.view.bounds.height / 6.0)
        }
    }
}

protocol MediaView: AnyObject {
    func showMedia(_ slide: Slide)
}
