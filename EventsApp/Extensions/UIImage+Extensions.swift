//
//  UIImage+Extensions.swift
//  EventsApp
//
//  Created by icedoutxcv on 11/10/2020.
//

import UIKit

extension UIImage {
    func sameAspectRation(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / size.height
        let newWidth = size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: .init(origin: .zero, size: newSize))
        }
    }
}
