//
//  AlbumDetailCoordinator.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 10/5/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import Foundation
import UIKit

protocol  AlbumDetailCoordinatorDelegate {
    func goToAppstore(url:URL)
}

struct AlbumDetailCoordinator {
    private var viewController:ViewController? = nil
    private var album:Album?
    init(presenter:ViewController?, album:Album?) {
        self.viewController = presenter
        self.album = album
    }
}

extension AlbumDetailCoordinator: BaseCoordinatorProtocol {
     func start()
     {
        if let albumVC = self.viewController, let navigationVC = albumVC.navigationController {
            let albumDetailVC = AlbumDetailViewController()
            albumDetailVC.viewModel = AlbumDetailsViewModel(album: self.album, imageCache: AlbumDataManager.imageCache,delegate: self)
            navigationVC.pushViewController(albumDetailVC, animated: true)
        }
     }
    
    func finish(){
        
    }
}

extension AlbumDetailCoordinator: AlbumDetailCoordinatorDelegate {
    func goToAppstore(url: URL) {
       if   UIApplication.shared.canOpenURL(url)  {
        UIApplication.shared.open(url)
        }
    }
}
