//
//  SlidePresenter.swift
//  Presentation App
//
//  Created by MacBook on 07.08.2023.
//

import Foundation

class SlidePresenter: SlidePresenterDelegate {
    private var mediaItems: [Slide] = []
    private var currentMediaIndex = 0
    private var view: MediaView?

    init(view: MediaView) {
        self.view = view
        // Initialize media items here
    }

    func loadNextMedia() {
        currentMediaIndex = (currentMediaIndex + 1) % mediaItems.count
        view?.showMedia(mediaItems[currentMediaIndex])
    }

    func loadPreviousMedia() {
        currentMediaIndex = (currentMediaIndex + mediaItems.count - 1) % mediaItems.count
        view?.showMedia(mediaItems[currentMediaIndex])
    }
}

protocol SlidePresenterDelegate {
    func loadNextMedia()
    func loadPreviousMedia()
}
