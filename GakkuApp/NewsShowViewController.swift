
//
//  NewsShowViewController.swift
//  GakkuApp
//
//  Created by macbook on 07.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class NewsShowViewController: UIViewController {
    
    var post: GakkuApi?
    
    lazy var activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
                activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        return activityIndicator
    }()
   
    
    lazy var webView: UIWebView = {
      let webView = UIWebView()
        webView.delegate = self
        webView.scrollView.delegate = self
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.backgroundColor = .white
        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        view.backgroundColor = .white
        
        constrains() 

        
        guard let data = String(htmlEncodedString: (self.post?.content)!) else { return }
        self.webView.loadHTMLString(data, baseURL: nil)

    }
    
    func constrains(){
        constrain(webView, activityIndicator, view){ wv, ai, v  in
            wv.top == v.top
            wv.left == v.left + 10
            wv.right == v.right - 10
            wv.height == v.height
            ai.center == v.center
        }
        
    }
}

extension NewsShowViewController: UIWebViewDelegate, UIScrollViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x > 0){
            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
        }
    }
    
}
