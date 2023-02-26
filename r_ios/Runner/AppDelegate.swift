import UIKit
import Firebase;
import Flutter;

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    };
    
    // <Add>
    override func applicationWillResignActive(
      _ application: UIApplication
    ) {
        self.window.endEditing(true)
      self.window.isHidden = true;
    }
    override func applicationDidBecomeActive(
        
      _ application: UIApplication
    ) {
        self.window.endEditing(true)
      self.window.isHidden = false;
    }
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        self.window.endEditing(true)
        print("entered background")
    }
    
}

extension UIWindow{
    func makeSecure() {
        let field = UITextField()
        field.isSecureTextEntry = true;
        self.addSubview(field)
        field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.first?.addSublayer(self.layer)
    }
}
