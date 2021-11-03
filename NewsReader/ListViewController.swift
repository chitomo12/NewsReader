//
//  ListViewController.swift
//  NewsReader
//
//  Created by 福田正知 on 2021/11/03.
//

//import Foundation
import UIKit

class ListViewController: UITableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Storyboard上で「Cell」とアイデンティファイしたアイテムと関連づける
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "article title"
        return cell
    }
}
