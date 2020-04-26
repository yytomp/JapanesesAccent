//
//  dictionary.swift
//  leftRIghtGame
//
//  Created by Matthew Anning on 18/4/20.
//  Copyright © 2020 Matthew Anning. All rights reserved.
//

import UIKit

class dictionary: UIViewController {
    var words = [Word]()
    var searchWords = [Word]()
    var searching = false
    let database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabasesdfg")
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //migrateData()
        words = database.selectAllWords()
        // Do any additional setup after loading the view.
    }
    
    func migrateData(){
        let fileURLProject = Bundle.main.path(forResource: "Verb_2mora_1", ofType: "txt")
        var readStringProject = ""
        do{
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
        }catch let error as NSError{
            print("Failed to read from project")
            print(error)
        }
        var data:[String] = []
        var parts = readStringProject.components(separatedBy: "\r\n")
        parts.remove(at:36)
        
        for part in parts{
            data.append(part)
        }
        
        
        for word in data{
            let temp = word.components(separatedBy: CharacterSet(charactersIn: "!:"))
            let id = (temp[1] as NSString).intValue
            let kanji = temp[3]
            let hiragana = temp[5]
            let Length = (temp[7] as NSString).intValue
            let diff = (temp[9] as NSString).intValue
            let eng = temp[11]
            
            database.insert(word: Word(ID:id, Kanji:kanji, Hiragana:hiragana, Length:Length, Difficulty:diff,English:eng))
        }

    }

    

}

extension dictionary: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchWords.count
        }
        return words.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var word = words[indexPath.row]
        if searching {
            word = searchWords[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordUITableViewCell") as! wordUITableViewCell
        cell.kanji.text = word.Kanji
        cell.hiragana.text = word.Hiragana
        cell.english.text = word.English
        cell.length.text = String(word.Length)
        
                
        return cell
    }
}

extension dictionary: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWords = words.filter( {$0.Hiragana.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
}
