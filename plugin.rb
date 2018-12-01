# name: BBCode
# about: adds BBCode to Discourse
# version: 0.1
# authors: Régis Hanol, Sam Saffron

register_asset "stylesheets/bbcode.scss"

register_svg_icon "fa-underline" if respond_to?(:register_svg_icon)
register_svg_icon "fa-indent" if respond_to?(:register_svg_icon)
register_svg_icon "fa-align-left" if respond_to?(:register_svg_icon)
register_svg_icon "fa-align-center" if respond_to?(:register_svg_icon)
register_svg_icon "fa-align-right" if respond_to?(:register_svg_icon)
register_svg_icon "fa-align-justify" if respond_to?(:register_svg_icon)
register_svg_icon "fa-palette" if respond_to?(:register_svg_icon)
register_svg_icon "fa-font" if respond_to?(:register_svg_icon)
register_svg_icon "fa-gavel" if respond to?(:register_svg_icon)
