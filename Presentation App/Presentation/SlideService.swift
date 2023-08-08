//
//  SlideService.swift
//  Presentation App
//
//  Created by MacBook on 08.08.2023.
//

class SlideService {
    let slides = [Slide(type: .image, content: "MVP_test_intro"),
                  Slide(type: .image, content: "MVP_test (dragged)"),
                  Slide(type: .image, content: "MVP_test (dragged) 2")]
    func fetchSlide(index: Int, callBack: @escaping (Slide, Int) -> Void){
        callBack(slides[index], slides.count)
    }
}
