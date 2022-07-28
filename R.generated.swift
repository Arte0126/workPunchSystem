//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `MSBBarChart`.
    static let msbBarChart = Rswift.FileResource(bundle: R.hostingBundle, name: "MSBBarChart", pathExtension: "")

    /// `bundle.url(forResource: "MSBBarChart", withExtension: "")`
    static func msbBarChart(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.msbBarChart
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `Image`.
    static let image = Rswift.ImageResource(bundle: R.hostingBundle, name: "Image")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Image", bundle: ..., traitCollection: ...)`
    static func image(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.image, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `BasicCalloutView`.
    static let basicCalloutView = _R.nib._BasicCalloutView()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "BasicCalloutView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.basicCalloutView) instead")
    static func basicCalloutView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.basicCalloutView)
    }
    #endif

    static func basicCalloutView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> BasicCalloutView? {
      return R.nib.basicCalloutView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? BasicCalloutView
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `cell`.
    static let cell: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "cell")

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _BasicCalloutView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "BasicCalloutView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> BasicCalloutView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? BasicCalloutView
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = WorkNavigationController

      let bundle = R.hostingBundle
      let name = "Main"
      let viewErrorListC = StoryboardViewControllerResource<ViewErrorListC>(identifier: "ViewErrorListC")
      let viewHomeC = StoryboardViewControllerResource<ViewHomeC>(identifier: "ViewHomeC")
      let viewWorkChartC = StoryboardViewControllerResource<ViewWorkChartC>(identifier: "ViewWorkChartC")
      let viewWorkDoneC = StoryboardViewControllerResource<ViewWorkDoneC>(identifier: "ViewWorkDoneC")
      let viewWorkOrderC = StoryboardViewControllerResource<ViewWorkOrderC>(identifier: "ViewWorkOrderC")
      let viewWorkPunchC = StoryboardViewControllerResource<ViewWorkPunchC>(identifier: "ViewWorkPunchC")
      let viewWorkSelectC = StoryboardViewControllerResource<ViewWorkSelectC>(identifier: "ViewWorkSelectC")

      func viewErrorListC(_: Void = ()) -> ViewErrorListC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: viewErrorListC)
      }

      func viewHomeC(_: Void = ()) -> ViewHomeC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: viewHomeC)
      }

      func viewWorkChartC(_: Void = ()) -> ViewWorkChartC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: viewWorkChartC)
      }

      func viewWorkDoneC(_: Void = ()) -> ViewWorkDoneC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: viewWorkDoneC)
      }

      func viewWorkOrderC(_: Void = ()) -> ViewWorkOrderC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: viewWorkOrderC)
      }

      func viewWorkPunchC(_: Void = ()) -> ViewWorkPunchC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: viewWorkPunchC)
      }

      func viewWorkSelectC(_: Void = ()) -> ViewWorkSelectC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: viewWorkSelectC)
      }

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "location.viewfinder") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'location.viewfinder' is used in storyboard 'Main', but couldn't be loaded.") } }
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "pip.exit") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'pip.exit' is used in storyboard 'Main', but couldn't be loaded.") } }
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "repeat") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'repeat' is used in storyboard 'Main', but couldn't be loaded.") } }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.main().viewErrorListC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'viewErrorListC' could not be loaded from storyboard 'Main' as 'ViewErrorListC'.") }
        if _R.storyboard.main().viewHomeC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'viewHomeC' could not be loaded from storyboard 'Main' as 'ViewHomeC'.") }
        if _R.storyboard.main().viewWorkChartC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'viewWorkChartC' could not be loaded from storyboard 'Main' as 'ViewWorkChartC'.") }
        if _R.storyboard.main().viewWorkDoneC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'viewWorkDoneC' could not be loaded from storyboard 'Main' as 'ViewWorkDoneC'.") }
        if _R.storyboard.main().viewWorkOrderC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'viewWorkOrderC' could not be loaded from storyboard 'Main' as 'ViewWorkOrderC'.") }
        if _R.storyboard.main().viewWorkPunchC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'viewWorkPunchC' could not be loaded from storyboard 'Main' as 'ViewWorkPunchC'.") }
        if _R.storyboard.main().viewWorkSelectC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'viewWorkSelectC' could not be loaded from storyboard 'Main' as 'ViewWorkSelectC'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}