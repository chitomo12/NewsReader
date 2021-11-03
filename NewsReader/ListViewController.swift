//
//  ListViewController.swift
//  NewsReader
//
//  Created by 福田正知 on 2021/11/03.
//

//import Foundation
import UIKit

class ListViewController: UITableViewController, XMLParserDelegate {
    
    var parser:XMLParser!
    var items = [Item]()
    var item:Item?
    var currentString = ""
    
    // セルの数を設定するメソッド
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // セルの内容を設定するメソッド
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Storyboard上で「Cell」とアイデンティファイしたアイテムと関連づける
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDownload()
    }
    
    func startDownload() {
        self.items = []
        if let url = URL(
            string: "https://wired.jp/rssfeeder/") {
            if let parser = XMLParser(contentsOf: url) {
                self.parser = parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentString = ""
        if elementName == "item" {
            self.item = Item()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "title": self.item?.title = currentString
        case "link": self.item?.link = currentString
        case "item": self.items.append(self.item!)
        default: break
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    // DetailViewControllerとの連携
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // ユーザーがタップしたセルの行番号を取得するには
        // indexPathForSelectedRowプロパティを使う。
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = items[indexPath.row]
            // 遷移先のビューコントローラーを格納
            let controller = segue.destination as! DetailViewController
            // ナビゲーションバーに表示する記事タイトル
            controller.title = item.title
            controller.link = item.link
        }
    }
}
