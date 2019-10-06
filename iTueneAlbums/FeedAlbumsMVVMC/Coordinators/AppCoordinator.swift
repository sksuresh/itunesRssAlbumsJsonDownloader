//
//  AppCoordinator.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 10/4/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import Foundation
import UIKit

protocol BaseCoordinatorProtocol {
    
    func start()
    func finish()
}

protocol  AppCoordinatorDelegate {
    func goToAlbumDetailController(album:Album?)
}

class AppCoordinator {
    private var window:UIWindow? = nil
    private var albumViewController:ViewController?
    
    init(presenter:UIWindow?) {
        self.window = presenter
    }
    
}

extension AppCoordinator : AppCoordinatorDelegate {
    func goToAlbumDetailController(album:Album?){
        AlbumDetailCoordinator(presenter: self.albumViewController,album: album).start()
    }
}

extension AppCoordinator : BaseCoordinatorProtocol {
    
    func start() {
        let albumViewController = ViewController()
        albumViewController.viewModel = AlbumViewModel(feed: nil, imageCache: AlbumDataManager.imageCache, delegate: self, dataManager: AlbumDataManager())
        let navigationControler = UINavigationController(rootViewController: albumViewController)
        self.albumViewController = albumViewController
        self.window?.rootViewController = navigationControler
    }
    
    func finish() {
        self.window = nil
    }
}
