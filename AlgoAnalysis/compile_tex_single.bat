@echo off
chcp 936 >nul
:: 用法：compile_tex_single.bat input.tex [output_dir]

:: 参数检查（增强版）
if "%~1"=="" (
    echo Usage: %~nx0 input.tex [output_dir]
    echo Example: %~nx0 ".\chapters\file.tex" ".\output"
    exit /b 1
)
if not exist "%~1" (
    echo Error: Input file "%~1" not found
    exit /b 1
)

:: 设置路径变量（支持带空格的相对路径）
set "input_file=%~1"
set "output_dir=%~2"

:: 默认输出目录为当前目录
if "%output_dir%"=="" set "output_dir=."

:: 自动创建输出目录（支持多级目录）
if not exist "%output_dir%" mkdir "%output_dir%"

echo Starting continuous compilation with latexmk...
:: 使用latexmk进行持续编译（添加-pvc自动预览）
latexmk -pvc -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory="%output_dir%" "%input_file%"
if errorlevel 1 (
    echo Error: latexmk compilation failed for "%input_file%"
    exit /b 1
)

del "%output_dir%\*.aux" "%output_dir%\*.log" "%output_dir%\*.fls" "%output_dir%\*.fdb_latexmk" "%output_dir%\*.synctex.gz" "%output_dir%\*.xdv" "%output_dir%\*.toc"2>nul

:: 注：使用-pvc模式时不需要手动清理文件，按Ctrl+C退出时会自动清理
:: 结果输出（显示完整路径）
for %%I in ("%output_dir%\%~n1.pdf") do (
    if exist "%%~fI" (
        echo Success: PDF generated at "%%~fI"
    ) else (
        echo Error: PDF not generated
        exit /b 1
    )
)