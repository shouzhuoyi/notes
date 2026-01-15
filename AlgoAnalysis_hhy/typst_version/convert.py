import os
import subprocess
from pathlib import Path

def convert_tex_to_typ():
    # 获取当前工作目录
    current_dir = Path.cwd()
    
    # 递归查找所有的 .tex 文件
    tex_files = list(current_dir.rglob("*.tex"))
    
    if not tex_files:
        print("未找到任何 .tex 文件。")
        return

    print(f"找到 {len(tex_files)} 个文件，开始转换...")

    for tex_path in tex_files:
        # 定义输出文件的路径：保持文件名不变，后缀改为 .typ
        output_path = tex_path.with_suffix(".typ")
        
        # 构建命令
        # pandoc [输入文件] -s --mathml -o [输出文件]
        command = [
            "pandoc",
            str(tex_path),
            "-s",
            "--mathml",
            "-o",
            str(output_path)
        ]
        
        try:
            # 执行命令
            subprocess.run(command, check=True)
            print(f"成功: {tex_path.name} -> {output_path.name}")
        except subprocess.CalledProcessError as e:
            print(f"错误: 转换 {tex_path.name} 时出错。原因: {e}")
        except FileNotFoundError:
            print("错误: 未能在系统中找到 'pandoc'，请确保已安装并添加到环境变量。")
            return

    print("\n所有任务处理完毕。")

if __name__ == "__main__":
    convert_tex_to_typ()