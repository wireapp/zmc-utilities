//
// Wire
// Copyright (C) 2020 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

/// A collection of flags each indicating whether a specific feature is enabled
/// or not.
///
/// Use these flags to conditionally run feature specific code. The flags are
/// statically accessible via the `shared` instance and can be configured with
/// JSON formatted data.

public struct FeatureFlags: Decodable {

  /// The shared instance. By default, all features are disabled.

  public static var shared = FeatureFlags()

  /// Whether conference (SFT) calling is enabled.

  public var conferenceCalling = false

}
