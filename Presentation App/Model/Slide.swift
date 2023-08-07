//
//  Slide.swift
//  Presentation App
//
//  Created by MacBook on 07.08.2023.
//

import Foundation

struct Slide {
    var type: SlideType
    var content: String
}

enum SlideType {
    case image
    case video
}
