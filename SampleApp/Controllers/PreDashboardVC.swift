import UIKit
import QuartzCore

// GURDEV CHANGES

class PreDashboardVC: BaseViewController {
    
    @IBOutlet   var logoView : UIView!
    var RADIUS:CGFloat = 92.0
    let LINE_WIDTH:CGFloat = 20.0
    let animation_duration = 0.5
    var arrayOfCircles:NSMutableArray=NSMutableArray()
    var VIEWCENTER:CGPoint=CGPoint(x: 0, y: 0)
    var qline = CAShapeLayer()
    var arrayImageViews:[UIButton]=[UIButton]()
    var arrayOfLayers:NSMutableArray=NSMutableArray()
    var imageViewOuterCircle:[UIImageView]=[UIImageView]()
    var appLifeStyleVC:AppLifeStyleVC?
    
    var icons:[String]=[String]()
    var hraIDs:[String]=[String]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.logoView.layoutIfNeeded()
        RADIUS = self.logoView.frame.size.width/3
        VIEWCENTER = self.logoView.center
        VIEWCENTER.y=VIEWCENTER.y-10
        
        
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        navigationController?.navigationBar.hidden = true
        
        navigationController?.navigationBar.tintColor = UIColor.clearColor()
        self.navigationController?.navigationBarHidden = true
        drawGradient()
    }
    
    

    func drawGradient() {
//        let tf:ThemeFactory=ThemeFactory()
//        self.view.layer.insertSublayer(tf.GetTheme(AppInstance.applicationInstance.themeIndex!).dashboardLayer, atIndex: 0)
    }
    
  
    func clearLayers() {
        for layer in self.arrayOfLayers {
            layer.removeFromSuperlayer()
        }
        
        for circle in self.arrayOfCircles {
            circle.removeFromSuperview()
        }
        
        qline.removeFromSuperlayer()
    }
    
    func navigateToLifeStyleVC()
    {
        
        appLifeStyleVC = self.storyboard?.instantiateViewControllerWithIdentifier("appLifeStyleVC") as? AppLifeStyleVC
        let animation:CATransition = CATransition()
        animation.duration=1.5
        animation.type=kCATransitionPush
        animation.subtype=kCATransitionFromBottom
        animation.timingFunction=CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.navigationController?.view.layer .addAnimation(animation, forKey:nil)
        self.navigationController?.pushViewController(appLifeStyleVC!, animated:false)
        
    }
    
    
   

}




