#!/bin/bash
# TECHGURU Build Script
# Minifies CSS and JS files for production

echo "🔧 TECHGURU Build Script"
echo "========================"

# Check if required tools are installed
if ! command -v npx &> /dev/null; then
    echo "❌ Error: npm/npx not found. Please install Node.js first."
    exit 1
fi

# Create src directories if they don't exist
mkdir -p css/src js/src

# Backup source files (if not already backed up)
if [ ! -f "js/src/scripts.js" ]; then
    echo "📁 Backing up source JS files..."
    cp js/scripts.min.js js/src/scripts.js
    cp js/chat-widget.min.js js/src/chat-widget.js
fi

if [ ! -f "css/src/styles.css" ]; then
    echo "📁 Backing up source CSS files..."
    cp css/styles.min.css css/src/styles.css
    cp css/chat-widget-dark-glass.min.css css/src/chat-widget-dark-glass.css
fi

echo ""
echo "🔨 Minifying JavaScript files..."

# Minify JS files
npx terser js/src/scripts.js -o js/scripts.min.js --compress --mangle
echo "   ✓ scripts.min.js"

npx terser js/src/chat-widget.js -o js/chat-widget.min.js --compress --mangle
echo "   ✓ chat-widget.min.js"

echo ""
echo "🎨 Minifying CSS files..."

# Minify CSS files
npx csso css/src/styles.css --output css/styles.min.css
echo "   ✓ styles.min.css"

npx csso css/src/chat-widget-dark-glass.css --output css/chat-widget-dark-glass.min.css
echo "   ✓ chat-widget-dark-glass.min.css"

echo ""
echo "✅ Build complete!"
echo ""
echo "📊 File sizes:"
echo "   JS:  $(wc -c < js/scripts.min.js) bytes (scripts.min.js)"
echo "   JS:  $(wc -c < js/chat-widget.min.js) bytes (chat-widget.min.js)"
echo "   CSS: $(wc -c < css/styles.min.css) bytes (styles.min.css)"
echo "   CSS: $(wc -c < css/chat-widget-dark-glass.min.css) bytes (chat-widget-dark-glass.min.css)"
