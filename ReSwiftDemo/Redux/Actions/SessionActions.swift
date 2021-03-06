import Foundation
import ReSwift

enum SessionActions {
    
    struct NoSession: Action { }
    
    struct SetSession: Action {
        let session: Session
    }
    
    class SignIn: ApiRequest<Session> {
        init(credentials: Credentials) {
            super.init(resource: "api/login",
                       method: .post,
                       json: credentials.toJson())
        }
        
        override func onSuccess(response: Session) -> [Action] {
            return [SetSession(session: response)]
        }
    }
    
    class SignOut: ApiRequest<VoidResponse> {
        init() {
            super.init(resource: "api/logout", method: .get)
        }
        
        override func onSuccess(response: VoidResponse) -> [Action] {
            return [NoSession()]
        }
    }
}
