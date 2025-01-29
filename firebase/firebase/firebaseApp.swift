//
//  firebaseApp.swift
//  firebase
//
//  Created by An Luu on 1/28/25.
//

import SwiftUI
import SwiftData

import GoogleSignIn
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

#if FIXME_MAIN
@main
struct firebaseApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
#endif

@main
struct LearnFirebase: App {
  let SRC = "LearnFirebase"
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    let _ = print("\(SRC): Called")

    WindowGroup {
      Text(SRC)
        .onAppear {
            GIDSignIn.sharedInstance.configureDebugProvider(withAPIKey: "atluutran-google-calendar") { error in
              if let error {
                print("Error configuring `GIDSignIn` for App Check: \(error)")
              }
            }
            
          GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
              let SRC = self.SRC + ".restorePreviousSignIn"
              
              if user != nil {
                  print("\(SRC): user = \(user!)")
              }
              
              if error != nil {
                  print("\(SRC): error = \(error!)")
              }

            if let user = user {
              //self.authViewModel.state = .signedIn(user)
            } else if let error = error {
              //self.authViewModel.state = .signedOut
              print("There was an error restoring the previous sign-in: \(error)")
            } else {
              //self.authViewModel.state = .signedOut
            }
          }
        }
        .onOpenURL { url in
            let SRC = self.SRC + ".onOpenURL"
            print("\(SRC): url = \(url)|")

          GIDSignIn.sharedInstance.handle(url)
        }
    }
  }
} // LearnFirebase
