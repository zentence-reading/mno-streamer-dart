// Copyright (c) 2021 Mantano. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mno_shared/publication.dart';

/// Container of a publication
///
/// @var rootFile : a RootFile class containing the path the publication, the version
///                 and the mime type of it
///
/// @var drm : contain the brand, scheme, profile and license of DRM if it exist
abstract class Container {
  /// RootFile that contains the path to the publication, version and mime type.
  RootFile get rootFile;

  /// An optional Drm type if the publication is protected.
  Drm? get drm;
}

/// Errors related to [Container].
class ContainerError implements Exception {
  ContainerError._();

  /// Stream initialization failed.
  ContainerError.streamInitFailed();

  /// File not found.
  ContainerError.fileNotFound();

  /// File error.
  ContainerError.fileError();

  /// Creates an error for a missing file.
  static MissingFileError missingFile(String path) => MissingFileError(path);

  /// Creates an error for XML parsing issues.
  static XmlParseError xmlParse(Error underlyingError) =>
      XmlParseError(underlyingError);

  /// Creates an error for a missing link.
  static MissingLinkError missingLink(String title) => MissingLinkError(title);
}

// Make the specific error classes public
class MissingFileError extends ContainerError {
  final String path;

  MissingFileError(this.path) : super._();

  @override
  String toString() => 'Missing file at path: $path';
}

class XmlParseError extends ContainerError {
  final Error underlyingError;

  XmlParseError(this.underlyingError) : super._();

  @override
  String toString() => 'Error parsing XML: $underlyingError';
}

class MissingLinkError extends ContainerError {
  final String title;

  MissingLinkError(this.title) : super._();

  @override
  String toString() => 'Missing link with title: $title';
}
