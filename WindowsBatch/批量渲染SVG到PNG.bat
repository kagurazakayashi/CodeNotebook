TITLE 批量渲染SVG到PNG
ECHO 先替换SVG颜色
SET COLO=skyblue
MKDIR %COLO% && for %f in (*.svg) do inkscape "%f" --export-filename="%COLO%\%~nf-%COLO%.png" --export-width=1024 --export-height=
