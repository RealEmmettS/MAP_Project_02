//
//  ViewController.swift
//  MAP - Project 02
//
//  Created by Emmett Shaughnessy on 8/19/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var gameboard: UILabel!
    @IBOutlet weak var mole: UIButton!
    @IBOutlet weak var time: UILabel!
    
    var screenSize = CGRect()
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    
    var gameboardSize = CGRect()
    
    var restarting = false
    
    var gameTimer = Timer()
    
    //MARK: Score "didSet" Setup
    var score:Int = 0 {
        didSet{
            scoreText.text = "\(score)";
        }
    }
    
    
    //MARK:- Start of ViewDidLod
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
                
        
        //MARK: Screen Size
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        //MARK: Score Label Setup
        let scoreFontSize = screenHeight/10
        score = 0;
        scoreText.font = UIFont.systemFont(ofSize: scoreFontSize, weight: UIFont.Weight(90))
        time.text = "Time Left: 10"
        time.font = UIFont.systemFont(ofSize: (scoreFontSize-70), weight: UIFont.Weight(90))
        
        //MARK: Gameboard Setup
        gameboard.backgroundColor = UIColor.green
        gameboard.text = ""
        gameboardSize = gameboard.bounds
        gameboard.layer.masksToBounds = true
        gameboard.layer.cornerRadius = 30
        print("Gameboard Width: \(gameboardSize.width)\nGameboard Height: \(gameboardSize.height)")
        
        //MARK: Mole Setup
        let centerX = gameboard.center.x
        let centerY = gameboard.center.y
        mole.frame = CGRect(x: centerX, y: centerY, width: 50, height: 50)
        mole.setTitle("", for: .normal)
        //mole.backgroundColor = UIColor.brown
//        let moleImage = UIImage(named: "mole")
//        mole.setImage(moleImage!.withRenderingMode(.alwaysOriginal), for: .normal)
        setMoleMode(dead: false)
        //mole.center = gameboard.center

        
        
        
    }
    //MARK:- End of ViewDidLod
    
    
    override func viewDidAppear(_ animated: Bool) {
        beginAlert()
    }
    
    
    
    //MARK: Beggining Alert
    func beginAlert(){
        
        let instructions = """
            Welcome to Whack-A-Mole, CTE edition!
            
            The goal of this game is to get as many points as possible within the alloted amount of time. The default time is 10 seconds. To gain a point, find and click the mole.
            
            At the end of the game, shake your device to restart.
            
            To begin the game and start the time, press "Begin Game" below.
            """
        
        
        let alertToBegin = UIAlertController(title: "Instructions", message: instructions, preferredStyle: .alert)

        alertToBegin.addAction(UIAlertAction(title: "Begin Game", style: .default, handler: { action in
            self.restartTimer()
        }))
        
        self.present(alertToBegin, animated: true)
        
    }
    
    
    
    
    
    
    
    
    //MARK: Timer
    func restartTimer(_ totalTime: Int = 10){
                
        print("Timer Started")
        var timeLeft = totalTime
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Time Left: \(timeLeft)")
            timeLeft -= 1
            self.time.text = "Time Left: \(timeLeft)"
            
            if timeLeft == 0 {
                self.mole.isEnabled = false
                self.mole.isHidden = true
                self.scoreText.textColor = .red
                self.gameboard.backgroundColor = .darkGray
                timer.invalidate()
            }

        }//End of Timer
    }//End of restartTimer
    
    
    
    
    //MARK: Mole Pressed
    @IBAction func molePressed(_ sender: Any) {
        
        mole.isSelected = false
        
        score += 1
        setMoleMode(dead: true)
        
        // Find the button's width and height
        let moleWidth = mole.frame.width
        let moleHeight = mole.frame.height

        // Find the width and height of the enclosing view
        let boardWidth = gameboardSize.width
        let boardHeight = gameboardSize.height

        // Compute width and height of the area to contain the button's center
        let xwidth = boardWidth - moleWidth
        let yheight = boardHeight - moleHeight
        
        //print(boardWidth)
        //print(boardHeight)
        
        //Generate random x and y values
        let minX = 60
        let minY = 280
        let maxX = 320
        let maxY = 280
        let randomX = Int.random(in: minX..<Int(maxX))
        let randomY = Int.random(in: minY..<Int(boardHeight))
        
        print("Random X: \(randomX)")
        print("Random Y: \(randomY)")
        
        
        // Set the mole's X and Y to the random coordinates.
        self.mole.center.x = CGFloat(randomX)
        self.mole.center.y = CGFloat(randomY)
        
        self.setMoleMode(dead: false)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
//            // Set the mole's X and Y to the random coordinates.
//            self.mole.center.x = CGFloat(randomX)
//            self.mole.center.y = CGFloat(randomY)
//
//            self.setMoleMode(dead: false)
//            self.mole.isEnabled = true
//        }
        
        
        
    }
    
    
    //MARK:- End Mole Pressed
    
    
    
    func setMoleMode(dead: Bool){
        var moleImage:UIImage? {
            didSet{
                print("Mole image changed")
            }
        }
        
        if dead{
            mole.isHidden = true
            mole.isEnabled = false
            moleImage = UIImage(named: "deadMole")
        }else{
            mole.isHidden = false
            mole.isEnabled = true
            moleImage = UIImage(named: "mole")
        }
        
        mole.setImage(moleImage!.withRenderingMode(.alwaysOriginal), for: .normal)

    }
    
    
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Shake Detected")
            if time.text == "Time Left: 0"{
                reset()
            }
        }
    }
    
    
    func reset(){
        
        print("\n\n\n")
                
        //Mole Setup
        mole.center.x = gameboard.center.x
        mole.center.y = gameboard.center.y
        setMoleMode(dead: false)
        
        //Gameboard Setup
        gameboard.backgroundColor = UIColor.green
        gameboard.text = ""
        
        //Score Setup
        score = 0;
        scoreText.textColor = .black
        
        //Timer Setup
        time.text = "Time Left: 10"
        
        
        beginAlert()
        
    }
    


}//End of class

