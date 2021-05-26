
import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    func navigate(to route: Route)
}

protocol Coordination {
    
    var root: UIViewController { get }
    
    func start()
}
