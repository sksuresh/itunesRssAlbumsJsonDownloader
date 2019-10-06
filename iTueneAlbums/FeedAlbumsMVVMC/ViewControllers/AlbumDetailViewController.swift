//
//  AlbumDetailViewController.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 10/4/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
   private lazy var scrollView:UIScrollView = {
        let scrollVW = UIScrollView()
        scrollVW.translatesAutoresizingMaskIntoConstraints = false
        return scrollVW
    }()
    
   private lazy var imgView: UIImageView = {
        let imgVW = UIImageView()
        imgVW.translatesAutoresizingMaskIntoConstraints = false
        return imgVW
    }()
    
  private  lazy var stackView: UIStackView = {
    let stackVW = UIStackView()
        stackVW.axis = .vertical
        stackVW.alignment = .fill
        stackVW.spacing = 1
        stackVW.distribution = .fill
        stackVW.translatesAutoresizingMaskIntoConstraints = false
        return stackVW
    }()
    
   private  var hstackView: UIStackView  {
        let stackVW = UIStackView()
        stackVW.axis = .horizontal
        stackVW.alignment = .fill
        stackVW.spacing = 0
        stackVW.distribution = .fillProportionally
        stackVW.translatesAutoresizingMaskIntoConstraints = false
        return stackVW
    }
    
   private  var  labelName: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
    
    private var  labelValue: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    private var  labelSepetator: UILabel {
        let label = UILabel()
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
   private lazy var  btnAppStore: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("goToAppstore", for: .normal)
        button.addTarget(self, action: #selector(clickForAppstore), for: .touchUpInside)
        return button
    }()
    var viewModel:AlbumDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubViews()
        self.setupDetailViewsAndData()
    }
    
    private func setupSubViews(){
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        self.view.addSubview(self.btnAppStore)
        self.view.addSubview(self.imgView)
        self.scrollView.addSubview(stackView)
        setUpConstraints()
        self.imgView.image = UIImage(named: "gallery")
    }
    
    
    override func loadView() {
        self.view = UIView()
    }

    func setUpConstraints(){
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.imgView.bottomAnchor, constant: 5),
            ])
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imgView.widthAnchor.constraint(equalToConstant: 200.0),
            imgView.heightAnchor.constraint(equalToConstant: 200.0)
            ])
        NSLayoutConstraint.activate([
            btnAppStore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnAppStore.heightAnchor.constraint(equalToConstant: 40.0),
            btnAppStore.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 5.0),
            btnAppStore.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0)
            ])
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
    }
    
    @objc func clickForAppstore(sender:UIButton) {
        print("btn clicked")
        self.viewModel?.openUrl()
    }
  
}

extension AlbumDetailViewController {
    
    private func setupDetailViewsAndData(){
        guard  let viewModel = viewModel else { return }
        if  let album:Album = viewModel.album {
            self.title = album.name
            loadImage(album: album, viewModel:viewModel)
            let albumMirror = Mirror(reflecting: album)
            presentData(childern:albumMirror.children)
        }
        if  let geners:[Genres] = viewModel.album?.genres {
            for gener in geners {
                let albumMirror = Mirror(reflecting: gener)
                presentData(childern:albumMirror.children)
            }
        }
    }
    
    private func loadImage(album:Album,viewModel:AlbumDetailsViewModel) {
        if let imgUrl = album.artworkUrl100 as NSString?, let imgData =  viewModel.imageCache.object(forKey: imgUrl), let img = UIImage(data:  imgData as Data)   {
            self.imgView.image = img
        } else {
            viewModel.getImage(imgUrl:album.artworkUrl100 ?? "", completion: { (data:Data?) in
                DispatchQueue.main.async {
                    guard let data = data  else { return }
                    self.imgView.image = UIImage(data: data)
                }
            })
        }
    }
    
    private func presentData(childern:Mirror.Children){
        
        for child in childern {
            let lblName      = self.labelName
            let lblValue     = self.labelValue
            let hstackVW     = self.hstackView
            let lblSeperator = self.labelSepetator
            hstackVW.addArrangedSubview(lblName)
            hstackVW.addArrangedSubview(lblValue)
            stackView.addArrangedSubview(hstackVW)
            stackView.addArrangedSubview(lblSeperator)
            lblSeperator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
            lblName.text = child.label ?? ""
            lblValue.text = child.value as? String ?? ""
        }
        
    }
    
}
