//
//  SlidePresenter.swift
//  Presentation App
//
//  Created by MacBook on 07.08.2023.
//

import Foundation

final class SlidePresenter {
    // MARK: - Properties
    private let slideService: SlideService
    weak var presentationView: PresentationView?
    private var slidesTotal = 0
    private var currentIndex = 0 {
        didSet {
            if currentIndex < 0 {
                currentIndex = 0
            }
            if currentIndex > slidesTotal {
                currentIndex = slidesTotal
            }
        }
    }
    
    init(presentationView: PresentationView, slideService: SlideService) {
        self.presentationView = presentationView
        self.slideService = slideService
    }
    
    // MARK: - Action
    private func getSlide() {
        slideService.fetchSlide(index: currentIndex) { slide, total in
            self.slidesTotal = total
            self.presentationView?.loadSlide(slide: slide)
            
            if self.currentIndex == 0 {
                self.presentationView?.setupInitialButtons()
            } else if self.currentIndex == total - 1 {
                self.presentationView?.setupFinalButtons()
            } else {
                self.presentationView?.setupDefaultButtons()
            }
        }
    }
    
    public func loadNextSlide() {
        currentIndex += 1
        getSlide()
    }

    public func loadPreviousSlide() {
        currentIndex = (currentIndex - 1)
        getSlide()
    }
    
    public func initialSetup() {
        getSlide()    }
}


protocol PresentationView: AnyObject {
    func setupInitialButtons()
    func setupFinalButtons()
    func setupDefaultButtons()
    func loadSlide(slide: Slide)
}
