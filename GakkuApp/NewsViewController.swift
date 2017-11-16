//
//  ViewController.swift
//  GakkuApp
//
//  Created by Dayana Marden on 14.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import SDWebImage

var number = 1
var num = 1
class NewsViewController: UIViewController {
    
    var loadMoreStatus = false
    var page: Int = 1
    
    lazy var activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
//        activityIndicator.center = self.view.center?
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        return activityIndicator
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        return collectionView
    }()
    
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width:self.view.frame.width/2, height:self.view.frame.width/3.25)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    var news: [GakkuApi] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        loadData(page: page)
        configureView()
        configureConstraints()
        collectionView.backgroundColor = Constant.Colors.bgColorDark
    }
    func configureView(){
        self.title = Constant.Titles.news
             view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
    }
    func configureConstraints(){
        constrain(view, collectionView, activityIndicator) { v, cv, ai in
         cv.edges == v.edges
         ai.center == cv.center
        }
    }
    func loadData(page: Int) {
        if page == 1 {
            GakkuApi.get(page: page) { [unowned self] (array, error) in
                guard let newsList = array else {
                    print("Error")
                    return
                }
                self.news = newsList
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
        else {
            GakkuApi.get(page: page) { [unowned self] (array, error) in
                guard let newsList = array else { return }
                for arr in newsList {
                    self.news.append(arr)
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
             }
            }
        }
    func loadMore() {
        self.activityIndicator.startAnimating()
        if ( !loadMoreStatus ) {
            self.loadMoreStatus = true
            loadMoreBegin(newtext: "Stratechery", loadMoreEnd: {(x:Int) -> () in
                self.page += 1
                self.loadData(page: self.page)
                self.collectionView.reloadData()
                self.loadMoreStatus = false
             })
        }
    }
    
    func loadMoreBegin(newtext:String, loadMoreEnd:@escaping (Int) -> ()) {
        DispatchQueue.global().async {
            sleep(2)
            
            DispatchQueue.main.async() {
                loadMoreEnd(0)
            }
        }
    }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! NewsCollectionViewCell
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        let title = String(htmlEncodedString: news[indexPath.row].title!)
        cell.titleLabel.text = title
        if let imageLink = news[indexPath.row].imageLink,
            let url = URL(string: imageLink){
            cell.postImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "logo2"))
        }
            cell.backgroundColor = .white
        if  num == 3 {
            cell.titleLabel.font = UIFont(name: "OpenSans-Regular", size: 16)
            num = 1
        }
        else {
            cell.titleLabel.font =  UIFont(name: "OpenSans-Regular", size: 13)
            num += 1
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         var newSize: CGSize = CGSize(width: self.view.frame.width/2, height:self.view.frame.width/3.25)
        if number == 3 {
          newSize = CGSize(width: view.frame.width, height: self.view.frame.width/1.875)
          number = 1
        }
        else { number += 1 }
        return newSize
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        if deltaOffset <= 0 {  loadMore()  }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToPostVC(news[indexPath.row])
    }
    
    func goToPostVC(_ news: GakkuApi) {
        let vc = NewsShowViewController()
        vc.post = news
        navigationController?.pushViewController(vc, animated: true)
    }
}

