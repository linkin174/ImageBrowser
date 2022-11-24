

import Foundation
import NeedleFoundation
import UIKit
import UIKit.UIImage

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class GalleryDependency4eca8b5a4c53a00eece8Provider: GalleryDependency {

    var fetcher: FetchingProtocol {
        return rootComponent.fetcher
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->GalleryComponent
private func factory3f6310faededaf0644b9b3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return GalleryDependency4eca8b5a4c53a00eece8Provider(rootComponent: parent1(component) as! RootComponent)
}
private class FetcherDependency7023f5d007e2c27fedcfProvider: FetcherDependency {
    var networkService: NetworkingProtocol {
        return rootComponent.networkService
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->FetcherDiComponent
private func factoryf43f98bf6b497695416cb3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return FetcherDependency7023f5d007e2c27fedcfProvider(rootComponent: parent1(component) as! RootComponent)
}
private class RandomImageDependencyaccc2131f0b3c23c4112Provider: RandomImageDependency {

    var networkService: NetworkingProtocol {
        rootComponent.networkService
    }

    
    var fetcher: FetchingProtocol {
        return rootComponent.fetcher
    }

    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->RandomImageComponent
private func factory904667427fcc83f3fb87b3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RandomImageDependencyaccc2131f0b3c23c4112Provider(rootComponent: parent1(component) as! RootComponent)
}

#else
extension GalleryComponent: Registration {
    public func registerItems() {
        keyPathToName[\GalleryDependency.fetcher] = "fetcher-NetworkFetcher"
    }
}
extension RootComponent: Registration {
    public func registerItems() {


    }
}
extension FetcherDiComponent: Registration {
    public func registerItems() {
        keyPathToName[\FetcherDependency.networkService] = "networkService-NetworkingProtocol"
    }
}
extension RandomImageComponent: Registration {
    public func registerItems() {
        keyPathToName[\RandomImageDependency.fetcher] = "fetcher-NetworkFetcher"
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

private func register1() {
    registerProviderFactory("^->RootComponent->GalleryComponent", factory3f6310faededaf0644b9b3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->RootComponent->FetcherDiComponent", factoryf43f98bf6b497695416cb3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent->RandomImageComponent", factory904667427fcc83f3fb87b3a8f24c1d289f2c0f2e)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
