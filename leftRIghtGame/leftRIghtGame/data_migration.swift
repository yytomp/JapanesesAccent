
import Foundation

func migrateData(){
    var database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabasesdfg")
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
