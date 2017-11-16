//
//  CategoriesViewController.swift
//  GakkuApp
//
//  Created by Dayana Marden on 14.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class ChartsViewController: UIViewController {
    var youtubeList: [YoutubeParser] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChartsTableViewCell.self, forCellReuseIdentifier: "videoCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
        loadCharts()
        }
    func configureView(){
        self.title = Constant.Titles.charts
        view.backgroundColor = .gray
        self.view.addSubview(tableView)
    }
    func configureConstraints(){
        constrain(tableView, view) { tv, v in
            tv.edges == v.edges
        }
    }
    func loadCharts(){
        YoutubeParser.getPlaylistVideos(id: "PLHi0nru6byVZZRQ-9ydZt_dyWnPSMTmMO", count: 50) { [unowned self] (array, error) in
            guard let youtubeList = array else {
                print("Error")
                return
            }
            self.youtubeList = youtubeList
             self.tableView.reloadData()
    }
  }
}
extension ChartsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youtubeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = youtubeList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! ChartsTableViewCell
        cell.selectionStyle = .none
        cell.configure(with: video)
        cell.postImageView.clipsToBounds = true
        return cell
    }
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        let lastSectionIndex = tableView.numberOfSections - 1
    //        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
    //        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
    //            // print("this is the last cell")
    //            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    //            spinner.startAnimating()
    //            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
    //
    //            self.tableView.tableFooterView = spinner
    //            self.tableView.tableFooterView?.isHidden = false
    //        }
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let currentOffset = scrollView.contentOffset.y
    //        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
    //        let deltaOffset = maximumOffset - currentOffset
    //
    //        if deltaOffset <= 0 {
    //            loadMore()
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToPostVC(youtubeList[indexPath.row])
    }
    
    func goToPostVC(_ vid: YoutubeParser) {
        let vc = VideoViewController()
        vc.video = vid
        navigationController?.pushViewController(vc, animated: true)
    }
}
