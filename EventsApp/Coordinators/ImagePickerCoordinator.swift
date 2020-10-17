//
//  ImagePickerCoordinator.swift
//  EventsApp
//
//  Created by icedoutxcv on 10/10/2020.
//

import Foundation
import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator  {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var parentCoodinator: Coordinator?
    
    var onFinishPicking: (UIImage) -> Void = { _ in }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigationController.present(imagePickerController, animated: true, completion: nil)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            onFinishPicking(image)
        }
        parentCoodinator?.childDidFinish(self)
    }
}
