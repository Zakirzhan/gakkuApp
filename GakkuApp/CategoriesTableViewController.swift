//
//  CategoriesTableViewController.swift
//  GakkuApp
//
//  Created by macbook on 07.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography



struct MyPage {
    var title: String?
    var id: String?
    var imageLink: String?
    var date: String?
    var description: String?
}
class CategoriesViewController: UIViewController {
    var playList: [MyPage] = []

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.rowHeight = self.view.frame.width/1.875
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        playlistAppend()
        self.title = Constant.Titles.channel
        view.addSubview(tableView)
        configureConstraints()
     }
    func playlistAppend(){ 
        playList.append(MyPage(title: "#TUSAUKESER", id: "PLHi0nru6byVbyho7FAQ4867nxUa8ImCBp", imageLink: "https://i.ytimg.com/vi/KarmMEPHGmQ/hqdefault.jpg", date: "2015-02-23T05:57:04.000Z", description: "Самые свежие клипы Казахстанского музыкального мира"))
        playList.append(MyPage(title: "Караоке", id: "PLHi0nru6byVawb4E6Gd2lczYdzLOTPDGy", imageLink: "https://i.ytimg.com/vi/vrvRaG2QcJ4/hqdefault.jpg", date: "2017-05-24T08:57:32.000Z", description: "Караоке"))
        playList.append(MyPage(title: "Gakku Audio", id: "PLHi0nru6byVbMPF5ArWgABvEUDPH9_UKm", imageLink: "https://i.ytimg.com/vi/ASp2I9biwuw/hqdefault.jpg", date: "2016-04-04T09:30:21.000Z", description: "Gakku AUdios mp3s"))
        playList.append(MyPage(title: "Qazaq Pop Music", id: "PLHi0nru6byVaFATFuW16YFY6iLDxK3Kta", imageLink: "https://i.ytimg.com/vi/eLM-JVgXBTU/hqdefault.jpg", date: "2016-07-09T03:14:44.000Z", description: "KAZAKH POP MUSIC / ЗАМАНАУИ ҚАЗАҚСТАННЫҢ МУЗЫКАСЫ"))
        playList.append(MyPage(title: "ӘН - GIMME", id: "PLHi0nru6byVaFXd2796l5oEKwCHHuHoeI", imageLink: "https://i.ytimg.com/vi/Ht8V1hGZtO0/hqdefault.jpg", date: "2015-11-17T07:39:10.000Z", description: "ӘН-GIMME - видеочат со звездой на сайте gakku.kz"))
        playList.append(MyPage(title: "Дерек / Derec", id: "PLHi0nru6byVZ6kN9yaakotQuUa_BR4OoG", imageLink: "https://i.ytimg.com/vi/6Q3qg1ohkDs/hqdefault.jpg", date: "2017-05-24T05:45:04.000Z", description: "Деректер"))
        playList.append(MyPage(title: "Жобалар/Проекты", id: "PLHi0nru6byVajXeZ4fd8cKmE93rHxpFH0", imageLink: "https://i.ytimg.com/vi/Jbc_rvEzE-U/hqdefault.jpg", date: "2016-10-20T08:31:41.000Z", description: "Проекты"))
        playList.append(MyPage(title: "Backstage", id: "PLHi0nru6byVbC7B7uFVbRVewGAoNPFWTp", imageLink: "https://i.ytimg.com/vi/tnB7E_1Xbdw/hqdefault.jpg", date: "2016-05-01T05:10:37.000Z", description: "BackStage"))
    }
    func configureConstraints() {
        constrain(view, tableView){ v, tv in
            tv.edges == v.edges
        }
    }
 
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playList.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoriesTableViewCell
        let playlist = playList[indexPath.row]
        cell.configure(with: playlist)
          return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToPostVC(playList[indexPath.row])
    }
    
    func goToPostVC(_ vid: MyPage) {
        let vc = ChannelViewController()
        vc.playlistID = vid.id!
        vc.playlistTitle = vid.title!
        navigationController?.pushViewController(vc, animated: true)
    }
}
 
