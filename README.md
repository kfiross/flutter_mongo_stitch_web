# flutter_mongo_stitch_web

The web implementation of [flutter_mongo_stitch](https://github.com/kfiross/flutter_mongo_stitch)

## Usage

### Import the package

This package is the endorsed implementation of `flutter_mongo_stitch` for the web platform since version `0.7.1`, so it gets automatically added to your dependencies by depending on `flutter_mongo_stitch: ^4.1.0`.

No modifications to your pubspec.yaml should be required in a recent enough version of Flutter (`>=1.12.13+hotfix.4`):

```yaml
...
dependencies:
  ...
  flutter_mongo_stitch: ^0.7.1
  ...
...
```


## Web integration

On your `web/index.html` file, add the following `script` tags, somewhere in the
`head` of the document:

```html
<head>
... other configurations

    <!-- Importing the official MongoStitch Javascript Browser SDK-->
    <script src="https://s3.amazonaws.com/stitch-sdks/js/bundles/4.9.0/stitch.js"></script>
    
    <!-- Importing the file that connects between dart & js implementations used by the web plugin-->
    <script src='https://fluttermongostitch.s3.us-east-2.amazonaws.com/stitchUtils.js'></script>

</head>
```
