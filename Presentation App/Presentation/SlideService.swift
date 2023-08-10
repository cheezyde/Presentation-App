//
//  SlideService.swift
//  Presentation App
//
//  Created by MacBook on 08.08.2023.
//

final class SlideService {
    private var slides = [Slide(type: .video, content: "barbie_video")]

    init() {
        for index in 1...34 {
            let slideName = "slide-\(index)"
            slides.append(Slide(type: .image, content: slideName))
        }
    }

    public func fetchSlide(index: Int, callBack: @escaping (Slide, Int) -> Void){
        callBack(slides[index], slides.count)
    }
}
