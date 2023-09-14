import Resolver
extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { LoginViewModel() }.scope(.application)
        register { AuthService() }.scope(.graph)
        register { AppStateManager() }.scope(.application)
    }
}
