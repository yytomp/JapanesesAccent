//
//  ViewController.swift
//  leftRIghtGame
//
//  Created by Matthew Anning on 1/2/20.
//  Copyright © 2020 Matthew Anning. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet var hiragana_display: UILabel!
    
    var cardViewOrigin: CGPoint!
    
    @IBOutlet weak var card: UIStackView!
    
    @IBOutlet var word_displaying: UILabel!
    let database : SQLiteDatabase = SQLiteDatabase(databaseName:"MyDatabasesdfg")
    var id = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        thumbImageView.autoresizingMask  = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleLeftMargin]
        
        cardViewOrigin = card.frame.origin
        
        let temp_word = database.selectWordBy(id: Int32(self.id))?.Kanji
        let temp_hiragana = database.selectWordBy(id: Int32(self.id))?.Hiragana
        word_displaying.text = temp_word
        hiragana_display.text = temp_hiragana
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let xFromCenter = card.center.x - view.center.x
        //let yFromCenter = card.center.y - view.center.y
        
        if xFromCenter > 0 {
            thumbImageView.image = UIImage(systemName: "hand.thumbsup")
            thumbImageView.tintColor = UIColor.green
        }else{
            thumbImageView.image  = UIImage(systemName: "hand.thumbsdown")
            thumbImageView.tintColor = UIColor.red
        }
        
        thumbImageView.alpha = abs(xFromCenter) / view.center.x
    
        
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: card, sender: sender)
        case .ended:
            swipeFunc(sender: sender)
        
        default:
            break
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer){
            
            let translation = sender.translation(in: view)
            
            view.center = CGPoint(x: view.center.x + translation.x, y:view.center.y + translation.y ) // moving the center of the wordLabel along with the traslation
            
            sender.setTranslation(CGPoint.zero, in: view)
        }
        
        	
        func returnViewToOrigin(view: UIView){
            UIView.animate(withDuration: 0.3, animations: {
                view.frame.origin = self.cardViewOrigin
                self.thumbImageView.alpha = 0
            })
        }
        
    
        func nextWord(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.resetCard()
            self.id += 1
            let temp = self.database.selectWordBy(id: Int32(self.id))?.Kanji
            self.word_displaying.text = temp
            let temp_hiragana = self.database.selectWordBy(id: Int32(self.id))?.Hiragana
            self.hiragana_display.text = temp_hiragana
            
        }
    }
        
        func resetCard(){
            self.thumbImageView.alpha = 0
            self.card.center = self.view.center
            self.card.alpha = 1
        }
        
        func swipeFunc(sender: UIPanGestureRecognizer){
            let card = sender.view!

            if card.center.x < 75{
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint (x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                    self.nextWord()
                })
                return
            }else if card.center.x > (view.frame.width - 75){
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint (x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                    self.nextWord()
                })
                return
            }else if card.center.y < 300 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint (x: card.center.x , y: card.center.y - 200)
                    card.alpha = 0
                    self.nextWord()
                })
                return
                
            }else if card.center.y > (view.frame.height - 200){
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint (x: card.center.x , y: card.center.y + 200)
                    card.alpha = 0
                    self.nextWord()
                })
                return
            }else{
                returnViewToOrigin(view: card)
            }
        }
    }

    // Refactor
    /*@objc func handlePan(sender: UIPanGestureRecognizer){
        
        let trashView = sender.view!
         
        //begin stage , change, and end
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: trashView, sender: sender)
            
        case .ended:
            if trashView.frame.intersects(pencilImageView.frame){
                deleteView(view: trashView)
            } else {
                returnTrashViewToOrigin(view: trashView)
               
            }
            
        default:
            break
        }
    }
 func deleteView(view: UIView){
     UIView.animate(withDuration: 0.5, animations:  {
         view.alpha = 0.0
                    })
 }
     
     /*
        func addPanGesture(view: UIView){
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
            
            view.addGestureRecognizer(pan)
            
        }
     */
    */
    
    

