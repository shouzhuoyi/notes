PKG_NAME="ysz_tools"
VERSION="0.1.0"
# macOS specific path for Typst local packages
DEST="$HOME/Library/Application Support/typst/packages/local/$PKG_NAME/$VERSION"

mkdir -p "$DEST"
cp lib.typ typst.toml "$DEST"
echo "已打包至 @local/$PKG_NAME:$VERSION"