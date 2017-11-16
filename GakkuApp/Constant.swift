//
//  Constant.swift
//  GakkuApp
//
//  Created by Zakirzhan Aisabaev on 15.11.2017.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    struct Titles {
        static let news = "Gakku News"
        static let charts = "Gakku Чарты"
        static let about = "О нас"
        static let channel = "Канал"
    }
    struct Colors {
        static let bgColorDark = UIColor(red:0.10, green:0.16, blue:0.25, alpha:1.0)
        static let dark = UIColor(red:0.10, green:0.16, blue:0.25, alpha:1.0)
        static let black = UIColor.black
        static let white = UIColor.white
        static let shadow = UIColor(white: 0, alpha: 0.3)
    }
    struct Settings {
        static let onlineTVId = "r5xwcIzVuVo"
        static let onlineStreamRadio = "https://stream.gakku.tv/radio/recordfm_192.mp3"
    }
    struct Icon {
        static let homeIcon = UIImage(named: "home")
        static let radioIcon = UIImage(named: "antenna")
        static let chartIcon = UIImage(named: "music")
        static let radyoIcon = UIImage(named: "antenna")
        static let channelIcon = UIImage(named: "search")
        static let aboutIcon = UIImage(named: "user")
    }
    struct Fonts {
        static let regular = "OpenSans-Regular"
        static let bold = "OpenSans-Bold"
        static let semibold = "OpenSans-SemiBold"
    }
    struct FontSizes {
        static let normal = CGFloat(14)
        static let big = CGFloat(16)
        static let bigger = CGFloat(24)
        static let mini = CGFloat(10)
    }

}

