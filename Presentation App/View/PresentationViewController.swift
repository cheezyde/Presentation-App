//
//  ViewController.swift
//  Presentation App
//
//  Created by MacBook on 07.08.2023.
//

import UIKit
import SnapKit
import AVKit
import AVFoundation

final class PresentationViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: SlidePresenter?
    private let playerController = AVPlayerViewController()
    
    // MARK: - UI
    private lazy var slideContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondaryColor")
        return view
    }()
    
    private lazy var slideImageView: UIImageView = {
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
        setupSlide()
    }
    

    // MARK: - Setup Views
    private func setupViews() {
        [slideContainer,
         backButton,
         nextButton].forEach {view.addSubview($0)}
        [slideImageView, playerController.view].forEach({slideContainer.addSubview($0)})
        view.backgroundColor = UIColor(named: "PrimaryColor")
    }
    
    private func setupSlide() {
        presenter = SlidePresenter(presentationView: self, slideService: SlideService())
        presenter?.initialSetup()
    }
    
    // MARK: - Action
    @objc private func prevButtonTapped() {
        if let presenter = presenter {
            presenter.loadPreviousSlide()
        }
    }

    @objc private func nextButtonTapped() {
        if let presenter = presenter {
            presenter.loadNextSlide()
        }
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
        slideContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(550)
            make.width.equalTo(750)
        }
        
        playerController.view.snp.makeConstraints { make in
            make.center.equalTo(slideContainer)
            make.height.equalTo(500)
            make.width.equalTo(700)
        }

        slideImageView.snp.makeConstraints { make in
            make.center.equalTo(slideContainer)
            make.height.equalTo(500)
            make.width.equalTo(700)
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

// MARK: - Presenter
extension PresentationViewController: PresentationView {
    func setupInitialButtons() {
        backButton.isHidden = true
    }
    
    func setupFinalButtons() {
        nextButton.isHidden = true
    }
    
    func setupDefaultButtons() {
        backButton.isHidden = false
        nextButton.isHidden = false
    }
    
    func loadSlide(slide: Slide) {
        if slide.type == .image {
            playerController.view.isHidden = true
            slideImageView.image = UIImage(named: slide.content)
        } else {
            playerController.view.isHidden = false
            guard let path = Bundle.main.path(forResource: slide.content, ofType:"mov") else {
                debugPrint("video.mp4 not found")
                return
            }
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            playerController.player = player
        }
    }
}
