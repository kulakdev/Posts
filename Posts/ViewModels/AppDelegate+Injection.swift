import Resolver
extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { LoginViewModel() }.scope(.application)
        register { AuthService() }.scope(.graph)
        register { DatabaseService() }.scope(.graph)
        register { DatabaseViewModel() }.scope(.application)
        register { AppStateManager() }.scope(.application)
    }
}
