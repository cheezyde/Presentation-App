//
//  SlidePresenter.swift
//  Presentation App
//
//  Created by MacBook on 07.08.2023.
//

import Foundation

class SlidePresenter {
    private let slideService: SlideService
    weak var presentationView: PresentationView?
    private var currentIndex = 0
    private var view: MediaView?

    init(view: MediaView, slideService: SlideService) {
        self.view = view
        self.slideService = slideService
    }
    
    func setupPresentation() {
        self.presentationView?.
    }
    
    func getSlide() {
        slideService.fetchSlide(index: currentIndex) {
            self.presentationView?.loadSlide(slide: $0)
            self.presentationView?.setupButtons()
        }
    }
    
    func loadNextMedia() {
        currentIndex = (currentIndex + 1) % mediaItems.count
        print(currentIndex)
        view?.showMedia(mediaItems[currentIndex])
    }

    func loadPreviousMedia() {
        currentIndex = (currentIndex + mediaItems.count - 1) % mediaItems.count
        view?.showMedia(mediaItems[currentIndex])
    }
}


protocol PresentationView: AnyObject {
    func setupButtons()
    func loadSlide(slide: Slide)
}
