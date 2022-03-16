//
//  DisplayData.swift
//  GifChallenge
//
//  Created by Mikalai on 11.03.2022.
//

import UIKit

class GifModel: NSObject {
    var imageURL: String
    var text: String

    init(imageURL: String, text: String) {
        self.imageURL = imageURL
        self.text = text
        super.init()
    }
}
