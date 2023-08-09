//
//  SlideService.swift
//  Presentation App
//
//  Created by MacBook on 08.08.2023.
//

final class SlideService {
    private let slides = [Slide(type: .video, content: "barbie_video"),
                  Slide(type: .image, content: "MVP_test_intro"),
                  Slide(type: .image, content: "MVP_test (dragged)"),
                  Slide(type: .image, content: "MVP_test (dragged) 2")]
    public func fetchSlide(index: Int, callBack: @escaping (Slide, Int) -> Void){
        callBack(slides[index], slides.count)
    }
}
