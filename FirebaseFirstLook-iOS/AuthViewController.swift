//
//  AuthViewController.swift
//  FirebaseFirstLook-iOS
//

import UIKit
import Firebase

class AuthViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtAuthStatus: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // TODO: check if user is signed in, if so then update status text
		if let user=FIRAuth.auth()?.currentUser{
			self.txtAuthStatus.text="Sign in as "+user.email!;
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Handle the Create User button tap
    */
    @IBAction func btnCreateUser(_ sender: AnyObject) {
        // TODO: Try to create a new user with supplied email and password
		if let email:String=txtEmail.text, let pass:String=txtPassword.text{
			FIRAuth.auth()?.createUser(withEmail: email, password: pass){
				(user,error) in
				if let error = error{
					self.txtAuthStatus.text=error.localizedDescription;
				}
				if let user=user{
					self.txtAuthStatus.text = "Please verify your email address before signing in";
					FIRAuth.auth()?.currentUser?.sendEmailVerification(){
						(error) in
						if let error=error{
							self.txtAuthStatus.text=error.localizedDescription;
						}
					};
					self.txtEmail.text=nil;
					self.txtPassword.text=nil;
					try! FIRAuth.auth()?.signOut();
				}
			}
		}
    }

    /**
     * Handle the Sign In button tap
     */
    @IBAction func btnSignIn(_ sender: AnyObject) {
        // TODO: Attempt to sign the user in
		if let email:String=txtEmail.text, let pass:String=txtPassword.text{
			FIRAuth.auth()?.signIn(withEmail: email, password: pass){
				(user, error)in
				if let error=error{
					self.txtAuthStatus.text=error.localizedDescription;
				}
				if let user=user{
					if(user.isEmailVerified){
						self.txtAuthStatus.text = "Sign in as "+user.email!;
						self.txtEmail.text=nil;
						self.txtPassword.text=nil;
					}else{
						self.txtAuthStatus.text="Please verify your email";
						self.txtEmail.text=nil;
						self.txtPassword.text=nil;
						try! FIRAuth.auth()?.signOut();
					}
					
				}
			}
		}

    }
    
    /**
     * Handle the Sign Out button tap
     */
    @IBAction func btnSignOut(_ sender: AnyObject) {
        // TODO: Sign the user out
		try! FIRAuth.auth()?.signOut();
        
        self.txtAuthStatus.text = "Signed Out";
        self.txtEmail.text = nil;
        self.txtPassword.text = nil;
    }
    
}
