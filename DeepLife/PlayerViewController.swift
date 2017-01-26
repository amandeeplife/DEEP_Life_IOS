//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: PlayerViewController
// Author Name		: Paul Prashant
// Date             : Oct, 18 2016
// Purpose			: Play you tube video.
//>---------------------------------------------------------------------------------------------------

import UIKit

class PlayerViewController: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    var videoID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.playerView.delegate = self
        self.playerView.load(withVideoId: videoID)
        self.showMBProgressHUD()
    }

    func showMBProgressHUD() {
        let hud = MBProgressHUD.showAdded(to: (self.tabBarController?.view)!, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "Loading..."
    }
    
    func hideMBProgressHUD() {
        MBProgressHUD.hide(for: (self.tabBarController?.view)!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState)
    {
        switch (state) {
        case YTPlayerState.playing:
            print("Started playback");
            self.hideMBProgressHUD()
            break;
        case YTPlayerState.paused:
            print("Paused playback");
            break;
        case YTPlayerState.ended:
            print("Ended playback");
            break;
        default:
            break;
        }
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView){
        print("player is ready")
        self.hideMBProgressHUD()
        self.playerView.playVideo()
    }
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError){
        print("player fail with error \(error)");
        self.hideMBProgressHUD()
        
        let alert = UIAlertController(title: "Sorry", message: "Unable to play", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}
