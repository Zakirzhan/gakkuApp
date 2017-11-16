//
//  CategoriesViewController.swift
//  GakkuApp
//
//  Created by Dayana Marden on 14.07.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class ChannelViewController: UIViewController {
    var youtubeList: [YoutubeParser] = []
    var playlistID: String = "PLHi0nru6byVbyho7FAQ4867nxUa8ImCBp"
    var playlistTitle: String = "Title"
    
    lazy var activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        //        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        return activityIndicator
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(YoutubeVideoTableViewCell.self, forCellReuseIdentifier: "videoCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        self.title = playlistTitle
        view.backgroundColor = .gray
        configureView()
        configureConstraints()
        YoutubeParser.getPlaylistVideos(id: playlistID, count: 30) { [unowned self] (array, error) in
            guard let youtubeList = array else {
                print("Error")
                return
            }
            self.youtubeList = youtubeList
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    func configureView(){
        [tableView,activityIndicator].forEach{
            self.view.addSubview($0)
        }
    }
    func configureConstraints(){
        constrain(tableView, activityIndicator, view) { tv, ai, v in
            tv.edges == v.edges
            ai.center == v.center
        }
    }
}
extension ChannelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youtubeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = youtubeList[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! YoutubeVideoTableViewCell
            cell.selectionStyle = .none
            cell.configure(with: video)
            cell.postImageView.clipsToBounds = true
            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToPostVC(youtubeList[indexPath.row])
    }
    
    func goToPostVC(_ vid: YoutubeParser) {
        let vc = VideoViewController()
        vc.video = vid
        navigationController?.pushViewController(vc, animated: true)
    }
}
