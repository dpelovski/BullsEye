import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var rounds = 0
    
    
    @IBOutlet weak var roundLable: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    //instance variable of the current slider value that I can use in viewDidLoad to set the currentValue of the slider
    
    @IBOutlet weak var targetLable: UILabel!
 
    override func viewDidLoad() {
        //The viewDidLoad() method is only called once when the view controller is created during app startup.
        super.viewDidLoad()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft"){
            
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        
        startNewGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        var alertMessage = ""
        
        if difference == 0 {
            alertMessage = "Perfect"
            points += 100
        } else if difference < 5 {
            alertMessage = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            alertMessage = "Pretty Good"
        } else {
            alertMessage = "Not even close..."
        }
        
        score += points
        
        let message = "You scored \(points) Score!"
        
        let alert = UIAlertController(title: alertMessage, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default, handler: {
            action in
            self.startNewRound()
            self.updateLabels()
        })
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100))
        ////generate a random number from 0 to 99 as the upper-limit is exclusive, so we add 1 to get numbers from 1 to 100
        currentValue = 50
        slider.value = Float(currentValue)
        rounds+=1
        updateLabels()

    }
    
    func updateLabels(){
       targetLable.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLable.text = String(rounds)
    }
    
    
    @IBAction func startNewGame(){
        rounds = 0
        score = 0
        startNewRound()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }
}


















