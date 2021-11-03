//
//  DetailViewController.swift
//  NewsReader
//
//  Created by 福田正知 on 2021/11/03.
//

import Foundation
import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var link: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: self.link) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
}
